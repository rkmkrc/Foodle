import { Request, Response } from 'express';
import { User } from '#Models/User';
import { UserCredentials } from '#Models/UserCredentials';
import { UserInfo } from '#Models/UserInfo';
import { Router } from 'express';
import { redisSetKey } from '#RedisHelper/RedisHelper';
import { registerNewUser, errorCodes } from '#SqlHelper/User';
import { sendOTP } from 'Services/OTPHelper';
import { randomInt } from 'crypto';

const userRegisterController = Router();

userRegisterController.post('/register', async (req: Request, res: Response) => {
	try {
		const userCredentials = req.body.userCredentials;
		const user = new UserCredentials(
			-1,
			userCredentials.userName,
			userCredentials.email,
			userCredentials.phoneNumber,
			userCredentials.hashedPassword
		);

		let registerResult: number = await registerNewUser(user);

		if (registerResult !== 0) {
			return res
				.status(500)
				.send({ message: errorCodes[registerResult], errorNumber: registerResult });
		}

		const otp = randomInt(100000, 900000).toString();
		await redisSetKey(user.getUserName() + '_otp', otp, 240);
		await sendOTP(user, otp);

		return res.status(200).send({ status: true, message: 'OTP has been sent.' });
	}
	catch (err) {
		return res.status(500).send({ error: err });
	}
});

export default userRegisterController;