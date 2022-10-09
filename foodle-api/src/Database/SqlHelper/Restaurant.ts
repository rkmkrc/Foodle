import postgreDB from '.';
import { reviewBody } from '#Types/types';

export async function getRestaurants(userFilter: any) {

	const dbResult = await postgreDB.any(
		`SELECT *
		FROM "Restaurant" r, (
			SELECT "m".restaurantID, COUNT("m".restaurantID) as reviewCount
			FROM "Review" r INNER JOIN "Meal" "m" ON r.mealID = m.mealID
			GROUP BY "m".restaurantID
		) as reviewCounts
		WHERE r.restaurantID = reviewCounts.restaurantID`
	)

	return dbResult;
}

export async function getDetailedRestaurantData(restaurantID: number) {
	const dbResultRestaurant: any = await postgreDB.oneOrNone(
		`SELECT *
		FROM "Restaurant", (
			SELECT COUNT(*) as reviewCount
			FROM "Restaurant" r INNER JOIN "Meal" "m" ON r.restaurantID = "m".restaurantID
				INNER JOIN "Review" re ON re.mealID = "m".mealID
			WHERE r.restaurantID = $1
			GROUP BY r.restaurantID
		) as reviewCount
		WHERE restaurantID = $1`,
		restaurantID
	);

	if (!dbResultRestaurant.reviewcount) dbResultRestaurant.reviewcount = 0;

	const dbResultMeal = await postgreDB.manyOrNone(
		`SELECT * FROM "Meal" WHERE restaurantID = $1`,
		restaurantID
	);

	const dbResultTop10Reviews = await postgreDB.any(
		`SELECT *
		FROM "Review" r INNER JOIN "Meal" "m" ON r.mealID = "m".mealID AND "m".restaurantID = $1, (
			SELECT userID, username
			FROM "UserCredential"
		) as username
		WHERE username.userID = r.userID
		ORDER BY r.score DESC LIMIT 10`,
		restaurantID
	);

	return {
		restaurantInfo: dbResultRestaurant,
		meals: dbResultMeal,
		reviews: dbResultTop10Reviews,
	};
}

export async function getRestaurantAllReviews(restaurantID: number) {
	const dbResult = await postgreDB.manyOrNone(
		`SELECT *
		FROM "Review" r INNER JOIN "Meal" "m" ON r.mealID = "m".mealID AND "m".restaurantID = $1, (
			SELECT userID, username
			FROM "UserCredential"
		) as username
		WHERE username.userID = r.userID
		ORDER BY r.score DESC`,
		restaurantID
	);

	return dbResult;
}

export async function getMealReviews(mealID: number) {
	const dbResult = await postgreDB.any(
		`SELECT * FROM "Review" WHERE mealID = $1`,
		mealID
	);

	return dbResult;
}

export async function getRestaurantMeals(restaurantID: number) {
	const dbResult = await postgreDB.any(
		`SELECT *
		FROM "Meal" "m" INNER JOIN (
			SELECT mealID, COUNT(*) as reviewCount
			FROM "Review"
			GROUP BY mealID
		) as reviewCount ON "m".mealID = reviewCount.mealID
        WHERE "m".restaurantID = $1`,
		restaurantID
	);

	return dbResult;
}

export async function getMeal(mealID: number) {
	const dbResult: any = await postgreDB.any(
		`SELECT *
		FROM "Meal", (
			SELECT COUNT(*) as reviewCount
			FROM "Review" r
			WHERE mealID = $1
			GROUP BY mealID
		) as reviewCount
		WHERE mealID = $1`,
		mealID);

	if (!dbResult.reviewcount) dbResult.reviewcount = 0;

	return dbResult;
}

export async function addMealReview(review: reviewBody) {
	if (review.userID === undefined || review.mealID === undefined) {
		return { status: 406, message: 'userID or mealID is missing' };
	}

	/*
		Procedure already checks for if a review is already written by this user.
		If there is an existing review, updates it otherwise creates a new column.
	*/

	// const dbCheck = await postgreDB.oneOrNone(
	// 	'SELECT * FROM "Review" WHERE userID = $1 AND mealID = $2',
	// 	[review.userID, review.mealID]
	// );

	// if (dbCheck !== null) {
	// 	return { status: 403, message: 'Multiple reviews for same meal is not allowed.' };
	// }

	const reviewID = await postgreDB.proc('proc_reviewaction', [
		review.rate,
		review.text,
		null,
		review.userID,
		review.mealID,
		0
	]);

	return { status: 200, message: 'Review added.', reviewID: reviewID.r_reviewid };
}

export async function deleteMealReview(reviewID: Number) {
	const dbCheck = await postgreDB.oneOrNone(
		'SELECT * FROM "Review" WHERE reviewID = $1',
		[reviewID]
	);

	if (dbCheck === null) {
		return { status: 404, message: 'Review does not exist with given ID.' };
	}

	await postgreDB.none(`DELETE FROM "Review" WHERE reviewID = $1`, reviewID);

	return { status: 200, message: 'Review deleted.' };
}

export async function voteReviewAction(
	userID: number,
	reviewID: number,
	action: string | null
) {
	await postgreDB.proc('proc_reviewvoteaction', [userID, reviewID, action]);
	return true;
}

export async function getReview(reviewID: number) {
	const dbCheck = await postgreDB.oneOrNone(
		'SELECT * FROM "Review" WHERE reviewID = $1',
		[reviewID]
	);

	if (dbCheck === null) {
		return { status: 404, message: 'Review does not exist with given ID.' };
	}

	return { status: 200, message: dbCheck };
}
