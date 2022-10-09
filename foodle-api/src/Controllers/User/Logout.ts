import { Request, Response } from 'express';
import { Router } from 'express';
import {
	checkAccessToken,
	deleteAccessToken,
	verifyUserCredentials,
} from '#SqlHelper/Auth';
const userLogoutController = Router();

userLogoutController.post('/logout', async (req: Request, res: Response) => {
	const status = await deleteAccessToken(req.headers.authorization as string);

	status
		? res.status(200).send({ message: 'User logout is successful.' })
		: res.status(404).send({ message: 'User already logged out.' });
});
export default userLogoutController;
