import { UserCredentials } from '#Models/UserCredentials';
import { redisDeleteKey, redisGetValue, redisSetKey } from '#RedisHelper/RedisHelper';
import postgreDB from '.';

export async function generateAccessToken(user: UserCredentials) {
	const dbResult = await postgreDB.oneOrNone(
		`SELECT accessToken FROM "UserCredential" WHERE userID=${user.getUserID()}`
	);

	let accessToken = dbResult?.accesstoken;
	if (accessToken) await redisSetKey(accessToken, String(user.getUserID()), 3600);
	else {
		accessToken = user.generateAccessToken();
		await redisSetKey(accessToken, String(user.getUserID()), 3600);
		const result = await postgreDB.one(
			`UPDATE "UserCredential" SET accessToken = $1 WHERE userID = $2 RETURNING accessToken`,
			[accessToken, user.getUserID()]
		);
	}
	return accessToken;
}

export async function deleteAccessToken(accessToken: string) {
	const result = await postgreDB.oneOrNone(
		`SELECT accessToken FROM "UserCredential" WHERE accesstoken='${accessToken}'`
	);

	if (result) {
		await Promise.all([
			postgreDB.oneOrNone(
				`UPDATE "UserCredential" SET accessToken=null WHERE accesstoken='${accessToken}'`
			),
			redisDeleteKey(accessToken),
		]);
		return true;
	}
	return false;
}

export async function checkAccessToken(userID: string, accessToken: string) {
	const redisUserID = await redisGetValue(accessToken);
	if (redisUserID !== null) return redisUserID === userID;

	const dbResult = await postgreDB.oneOrNone(
		`SELECT accessToken FROM "UserCredential" WHERE userID='${userID}'`
	);

	const fetchedAccessToken = dbResult?.accesstoken;

	if (fetchedAccessToken !== null && fetchedAccessToken === accessToken) {
		await redisSetKey(accessToken, userID, 3600);
		return true;
	} else {
		return false;
	}
}

export const verifyUserCredentials = async (userCredentials: { userName: string; hashedPassword: string; }) => {
	try {
		const result = await postgreDB.oneOrNone(
			`SELECT * FROM "UserCredential" WHERE username = $1 AND hashedPassword = $2`,
			[userCredentials.userName, userCredentials.hashedPassword]
		);

		return new UserCredentials(
			result.userid,
			result.username,
			result.email,
			result.phonenumber,
			result.hashedpassword,
			result.accesstoken == null ? '' : result.accesstoken
		);

	}
	catch (err) {
		return null;
	}

}