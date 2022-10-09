CREATE OR REPLACE FUNCTION trg_fn_calculateRate()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	mealID_l INT;
	mealRate_l FLOAT;
	restaurantID_l INT;
	restaurantRate_l FLOAT;
BEGIN
	IF OLD IS NULL THEN
		mealID_l := NEW.mealID;
	ELSE
		mealID_l := OLD.mealID;
	END IF;
	
	mealRate_l := (SELECT AVG(rate * 1.0) FROM "Review" WHERE mealID = mealID_l);
	
	UPDATE "Meal"
	SET rate = mealRate_l
	WHERE mealID = mealID_l;
	
	restaurantID_l := (SELECT restaurantID FROM "Meal" WHERE mealID = mealID_l);
	restaurantRate_l := (SELECT AVG(rate * 1.0) FROM "Meal" WHERE restaurantID = restaurantID_l);
	
	UPDATE "Restaurant"
	SET rate = restaurantRate_l
	WHERE restaurantID = restaurantID_l;
	
	RETURN NULL;
END;
$$

CREATE TRIGGER trg_calculateRate
	AFTER INSERT OR DELETE OR UPDATE
	ON "Review"
	FOR EACH ROW
	EXECUTE PROCEDURE trg_fn_calculateRate();
	
CREATE OR REPLACE FUNCTION trg_fn_calculateScore()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	reviewID_l INT;
	reviewScore_l INT;
	userID_l INT;
	userScore_l INT;
BEGIN
	IF OLD IS NULL THEN
		reviewID_l := NEW.reviewID;
		userID_l := NEW.userID;
	ELSE
		reviewID_l := OLD.reviewID;
		userID_l := OLD.userID;
	END IF;
	
	reviewScore_l := (SELECT COUNT(*) FROM "UserReviewVote" WHERE "type" = TRUE AND reviewID = reviewID_l);
	reviewScore_l := reviewScore_l - (SELECT COUNT(*) FROM "UserReviewVote" WHERE "type" = FALSE AND reviewID = reviewID_l);
	
	UPDATE "Review"
	SET score = reviewScore_l
	WHERE reviewID = reviewID_l;
	
	userScore_l := (SELECT SUM(score) FROM "Review" WHERE userID = userID_l);
	
	UPDATE "UserInfo"
	SET score = userScore_l
	WHERE userID = userID_l;
	
	RETURN NULL;
END;
$$

CREATE TRIGGER trg_calculateScore
	AFTER INSERT OR DELETE OR UPDATE
	ON "UserReviewVote"
	FOR EACH ROW
	EXECUTE PROCEDURE trg_fn_calculateScore();