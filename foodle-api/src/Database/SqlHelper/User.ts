import { User } from '#Models/User';
import { UserCredentials } from '#Models/UserCredentials';
import postgreDB from '.';

export const errorCodes: { [key: number]: string } = {
	0: 'success',
	1: 'duplicate username',
	2: 'duplicate email',
};

export const registerNewUser = async (userCredentials: UserCredentials) => {
	const registerResult = await postgreDB.proc('proc_register', [
		0,
		userCredentials.getUserName(),
		userCredentials.getHashedPassword(),
		userCredentials.getEmail(),
		userCredentials.getPhoneNumber(),
	]);

	return registerResult.r_errorcode;
};

export const getUserProfile = async (userID: number) => {
	const username = await postgreDB.oneOrNone(
		`SELECT username FROM "UserCredential" WHERE userID = $1`,
		userID
	);

	const userInfo = await postgreDB.oneOrNone(
		`SELECT * FROM "UserInfo" WHERE userID = $1`,
		userID
	);

	const followCounts = await postgreDB.proc('proc_followcounts', [userID, 0, 0]);

	const followers = await postgreDB.any(
		`SELECT ucf.userID, ucf.username, ucfi."profilePicture"
		FROM "UserCredential" ucu, "UserCredential" ucf, "UserInfo" ucfi, "UserFollow" uf
		WHERE ucu.userID = $1 AND
			  ucu.userID = uf.followingID AND
			  ucf.userID = uf.followerID AND
			  ucfi.userID = ucf.userID`,
		userID
	);

	const followings = await postgreDB.any(
		`SELECT ucf.userID, ucf.username, ucfi."profilePicture"
		FROM "UserCredential" ucu, "UserCredential" ucf, "UserInfo" ucfi, "UserFollow" uf
		WHERE ucu.userID = $1 AND
			  ucu.userID = uf.followerID AND
			  ucf.userID = uf.followingID AND
			  ucfi.userID = ucf.userID`,
		userID
	);

	const reviewCount = await postgreDB.oneOrNone(
		`SELECT COUNT(*) FROM "Review" WHERE userID = $1`,
		userID
	);

	const reviews = await postgreDB.any(
		`SELECT * FROM "Review" WHERE userID = $1 ORDER BY score DESC`,
		userID
	);

	const result = {
		username: username?.username,
		userInfo,
		followerCount: followCounts.r_followercount,
		followers,
		followingCount: followCounts.r_followingcount,
		followings,
		reviewCount: +reviewCount.count,
		reviews,
	};

	return result;
};

export const getUsers = async (keyword: string) => {
	const users = await postgreDB.any(
		`SELECT uc.userID, uc.username, ui."profilePicture"
		FROM "UserCredential" uc INNER JOIN "UserInfo" ui ON uc.userID = ui.userID
		WHERE uc.username ILIKE '%' || $1 || '%' OR
			ui.name ILIKE '%' || $1 || '%' OR
			ui.surname ILIKE '%' || $1 || '%'`,
		keyword
	);
	// get a list of users who have similar names.
	return users;
};

export const postUserFollowRequest = async (
	followingUserID: number,
	currentUserID: number
) => {
	try {
		const result = await postgreDB.proc('proc_followaction', [
			currentUserID,
			followingUserID,
			'',
		]);

		return result.r_result;
	} catch (err) {
		return err;
	}
};

export const updateUser = async (
	currentUserID: number,
	name?: string,
	surname?: string,
	birthDate?: Date,
	gender?: string,
	profilePicture?: string
) => {
	const dbCheck = await postgreDB.oneOrNone(
		`SELECT * FROM "UserInfo" WHERE userID = $1`,
		[currentUserID]
	);

	if (!dbCheck) {
		return { status: 404, message: 'User does not exists.' };
	}

	await postgreDB.oneOrNone(
		`UPDATE "UserInfo" SET name = $1, surname = $2, birthDate = $3, sex = $4, "profilePicture" = $5 WHERE userID = $6`,
		[
			name ?? dbCheck.name,
			surname ?? dbCheck.surname,
			birthDate ?? dbCheck.birthdate,
			gender ?? dbCheck.sex,
			profilePicture ?? dbCheck.profilepicture,
			currentUserID,
		]
	);

	return { status: 200, message: 'User profile successfully updated.' };
};
