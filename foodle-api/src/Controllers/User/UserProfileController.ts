import { Request, Response } from 'express';
import { Router } from 'express';
import {
	getUserProfile,
	getUsers,
	postUserFollowRequest,
	updateUser,
} from '#SqlHelper/User';
import { uploadUserPhoto } from 'Services/DataUpdateService';

const userProfileController = Router();

// user?userID=1212
userProfileController.get('', async (req: Request, res: Response) => {
	const userId = req.query.userID;
	const userData = await getUserProfile(Number(userId));
	if (userData === undefined || userData.username === undefined) {
		res.status(404).send();
	} else {
		res.status(200).send(userData);
	}
});

//user/getUsers?keyword=berk
userProfileController.get('/getUsers', async (req: Request, res: Response) => {
	const keyword = req.query.keyword?.toString();
	if (keyword !== undefined) {
		const users = await getUsers(keyword);
		if (users === undefined) {
			res.status(404);
		} else {
			res.status(200).send(users);
		}
	}
});

// user/follow?userID=121
userProfileController.post('/follow', async (req: Request, res: Response) => {
	const followingUserID = Number(req.query.userID);
	const currentUser = Number(req.headers.currentuserid);
	if (followingUserID && currentUser) {
		const result = await postUserFollowRequest(followingUserID, currentUser);
		if (result === "follow" || result === "unfollow") res.status(200).send({ message: `${result} request is successful.` });
		else res.status(500).send({ error: result });
	} else {
		res.status(500).send();
	}
});

// user/update
userProfileController.post('/update', async (req: Request, res: Response) => {
	const currentUser = Number(req.headers.currentuserid);
	const name = req.body.name === '' ? undefined : req.body.name;
	const surname = req.body.surname === '' ? undefined : req.body.surname;
	const birthDate = req.body.birthDate === '' ? undefined : req.body.birthDate;
	const gender = req.body.gender === '' ? undefined : req.body.gender;
	const photoData = req.body.data === '' ? undefined : req.body.data;

	if (photoData !== undefined) {
		const uploadResult = await uploadUserPhoto(req.body.data, String(currentUser));
		if (uploadResult.result !== 200) {
			return res.status(uploadResult.result).send(uploadResult.resultMessage);
		}
	}

	const result = await updateUser(
		currentUser,
		name,
		surname,
		birthDate,
		gender,
		`/users/${currentUser}/profile_photo.jpg`
	);

	return res.status(result.status).send({ message: result.message });
});

userProfileController.post('/uploadphoto', async (req: Request, res: Response) => {
	const uploadResult = await uploadUserPhoto(req.body.data, String(req.headers.currentuserid));
	res.status(uploadResult.result).send(
		uploadResult.resultMessage === undefined ?
			{ message: 'success' } :
			uploadResult.resultMessage);
});


export default userProfileController;
