import { checkAccessToken } from '#SqlHelper/Auth';
import { NextFunction, Request, Response } from 'express';

// const ignoredPaths = ['/auth/register', '/auth', '/auth/login'];
// -> Those aren't necessary anymore since we don't include this middlewae for userauthController.

export const authController = async (req: Request, res: Response, next: NextFunction) => {
	if (!req.headers.authorization) {
		return res.status(403).send({ message: 'Request without an auth token.' });
	} else if (!req.headers.currentuserid) {
		return res.status(403).send({ message: 'Request without an current user ID.' });
	} else {
		const result = await checkAccessToken(
			req.headers.currentuserid as string,
			req.headers.authorization as string
		);
		if (result) {
			return next();
		} else {
			return res.status(401).send({ message: 'Unauthorized access.' });
		}
	}
};

export const apiLogger = async (req: Request, res: Response, next: NextFunction) => {
	console.log('--------------------------------------');
	console.log('New Request ');
	console.log('Host name: ' + req.hostname);
	console.log('Request url: ' + req.path);
	console.log('Request http method: ' + req.method);
	console.log('--------------------------------------');
	next();
};
