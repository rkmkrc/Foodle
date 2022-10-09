import { Request, Response } from 'express';
import { Router } from 'express';
import { redisDeleteKey, redisGetValue, redisSetKey } from '#RedisHelper/RedisHelper';
import { generateAccessToken, verifyUserCredentials } from '#SqlHelper/Auth';
import { randomInt } from 'crypto';
import { sendOTP } from 'Services/OTPHelper';
const userLoginController = Router();

userLoginController.post('/login', async (req: Request, res: Response) => {
	if (Object.keys(req.query).length === 0) await firstLogin(req, res);
	else if (req.query.action !== undefined && req.query.action === 'confirmOTP') {
		await confirmOTP(req, res);
	}
});

async function firstLogin(req: Request, res: Response) {
	const result = await verifyUserCredentials(req.body.userCredentials);

	if (result) {
		if (result.getAccessToken() !== '') {
			const generatedAccessToken = await generateAccessToken(result);
			return res
				.status(200)
				.send({
					message: 'User is already logged in.',
					accesstoken: generatedAccessToken,
					userid: result.getUserID(),
				});
		}

		const otp = randomInt(100000, 900000).toString();
		await redisSetKey(result.getUserName() + '_otp', otp, 240);
		await sendOTP(result, otp);
		res.status(200).send({ message: 'OTP has been sent.' });
	} else {
		res.status(401).send({ message: 'Invalid user credentials.' });
	}
}

async function confirmOTP(req: Request, res: Response) {
	const result = await verifyUserCredentials(req.body.userCredentials);

	if (result !== null) {
		const otp = await redisGetValue(result.getUserName() + '_otp');
		if (otp === req.body.userCredentials.OTP) {
			await redisDeleteKey(result.getUserName() + '_otp');
			const generatedAccessToken = await generateAccessToken(result);
			res
				.status(200)
				.send({
					message: 'User login successful.',
					accesstoken: generatedAccessToken,
					userid: result.getUserID(),
				});
		} else {
			res.status(401).send({ message: 'Wrong OTP' });
		}
	} else {
		res.status(401).send({ message: 'Invalid user credentials.' });
	}
}

export default userLoginController;
