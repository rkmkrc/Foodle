import { Request, Response } from 'express';
import { Router } from 'express';
import {
	addMealReview,
	deleteMealReview,
	getMealReviews,
	getRestaurantAllReviews,
	getReview,
	voteReviewAction,
} from '#SqlHelper/Restaurant';
import { redisGetValue } from '#RedisHelper/RedisHelper';
import { uploadReviewPhoto } from 'Services/DataUpdateService';

const reviewActions: { [key: string]: string | null } = {
	upvote: 'TRUE',
	downvote: 'FALSE',
	delete: null,
};

const reviewController = Router();

// restaurant/review?restaurantID=12 or restaurant/review?mealID=12 or restaurant/review?reviewID=123
reviewController.get('/', async (req: Request, res: Response) => {
	const restaurantID = Number(req.query.restaurantID);
	const mealID = Number(req.query.mealID);
	const reviewID = Number(req.query.reviewID);

	if (!restaurantID && !mealID && !reviewID)
		return res.status(501).send({ message: 'Incorrect query value or argument.' });

	if (restaurantID) {
		const data = await getRestaurantAllReviews(restaurantID);
		return res.status(200).send(data);
	}

	if (mealID) {
		const data = await getMealReviews(mealID);
		return res.status(200).send(data);
	}

	if (reviewID) {
		const data = await getReview(reviewID);
		return res.status(200).send(data);
	}
});

// restaurant/review/add
reviewController.post('/add', async (req: Request, res: Response) => {
	try {
		const result = await addMealReview(req.body);
		let id = 0;
		req.body.photos.forEach(async (photo: string) => {
			await uploadReviewPhoto(photo, String(result.reviewID), ++id + '.jpg');
		});
		res.status(result.status).send({ message: result.message });
	} catch (err) {
		res.status(501).send({message: err});
	}
});

// restaurant/review/delete?reviewID=12
reviewController.post('/delete', async (req: Request, res: Response) => {
	const reviewID = req.query.reviewID;

	if (reviewID === undefined) {
		return res.status(403).send({ message: 'Query is missing.' });
	}

	const result = await deleteMealReview(Number(reviewID));

	res.status(result.status).send({ message: result.message });
});

// restaurant/review/vote?reviewID=123&action=upvote
// restaurant/review/vote?reviewID=123&action=downvote
// restaurant/review/vote?reviewID=123&action=delete
reviewController.post('/vote', async (req: Request, res: Response) => {
	const reviewID = Number(req.query.reviewID);
	const action = reviewActions[req.query.action as string];
	if (!action || !reviewID) return res.status(404).send();
	const userID = await redisGetValue(req.headers.authorization as string);
	const data = await voteReviewAction(Number(userID), Number(reviewID), action);

	res.status(200).send(data);
});

export default reviewController;
