import { checkAccessToken, verifyUserCredentials } from '#SqlHelper/Auth';
import { Request, Response } from 'express';
import { Router } from 'express';
const userAuthCheckController = Router();

userAuthCheckController.get('', async (req: Request, res: Response) => {
	const result = await checkAccessToken(
		req.headers.currentuserid as string,
		req.headers.authorization as string
	);

	if (result) res.status(200).send({ message: "true" });
	else res.status(404).send();
});

export default userAuthCheckController;
