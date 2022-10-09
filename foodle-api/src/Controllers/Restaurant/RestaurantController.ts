import { Request, Response } from 'express';
import { Router } from 'express';
import {
	getDetailedRestaurantData,
	getMeal,
	getRestaurantMeals,
	getRestaurants,
} from '#SqlHelper/Restaurant';

const restaurantController = Router();

restaurantController.get('/get', async (req: Request, res: Response) => {
	try {
		// const userRestaurantFilter = new UserRestaurantFilter(
		// 	req.body.GPS,
		// 	req.body.restaurantType
		// );
		const filteredRestaurants = await getRestaurants(req.body);

		// filter by location

		res.status(200).send(filteredRestaurants);
	} catch (err) {
		res.status(501).send({ message: err });
	}
});

// restaurant?id=12
restaurantController.get('', async (req: Request, res: Response) => {
	const restaurantID = Number(req.query.restaurantID);

	if (restaurantID === undefined || Number.isNaN(restaurantID)) {
		return res.status(404).send();
	}

	const data = await getDetailedRestaurantData(restaurantID);
	res.status(200).send(data);
});

// restaurant/meals?restaurantID=12
restaurantController.get('/meals', async (req: Request, res: Response) => {
	const restaurantID = Number(req.query.restaurantID);

	if (restaurantID === undefined || Number.isNaN(restaurantID)) {
		return res.status(404).send();
	}

	const data = await getRestaurantMeals(restaurantID);
	res.status(200).send(data);
});

// restaurant/meal?mealID=12
restaurantController.get('/meal', async (req: Request, res: Response) => {
	const mealID = Number(req.query.mealID);

	if (mealID === undefined || Number.isNaN(mealID)) {
		return res.status(404).send();
	}

	const data = await getMeal(mealID);
	res.status(200).send(data);
});

// restaurant/meals?restaurantID=12
restaurantController.get('/meals', async (req: Request, res: Response) => {
	const restaurantID = Number(req.query.restaurantID);

	if (restaurantID === undefined || Number.isNaN(restaurantID)) {
		return res.status(404).send();
	}

	const data = await getDetailedRestaurantData(restaurantID);
	res.status(200).send(data.meals);
});

export default restaurantController;
