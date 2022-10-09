CREATE OR REPLACE PROCEDURE proc_register(
	OUT r_errorCode INT,
	arg_username VARCHAR(32),
	arg_hashedPassword VARCHAR(128),
	arg_email VARCHAR(256),
	arg_phoneNumber VARCHAR(13) DEFAULT NULL,
	arg_name VARCHAR(256) DEFAULT NULL,
	arg_surname VARCHAR(256) DEFAULT NULL,
	arg_birthdate DATE DEFAULT NULL,
	arg_sex CHAR(1) DEFAULT NULL,
	arg_profilePicture VARCHAR(256) DEFAULT NULL
)
AS $$
DECLARE
	v_userID INT;
BEGIN
	r_errorCode := 0;

	IF EXISTS (SELECT * FROM "UserCredential" WHERE username = arg_username) THEN
		r_errorCode := 1;
		RETURN;
	END IF;
	
	IF EXISTS (SELECT * FROM "UserCredential" WHERE email = arg_email) THEN
		r_errorCode := 2;
		RETURN;
	END IF;
	
	INSERT INTO "UserCredential"(username, email, hashedPassword, phoneNumber)
	VALUES(arg_username, arg_email, arg_hashedPassword, arg_phoneNumber)
	RETURNING userID INTO v_userID;

	INSERT INTO "UserInfo"(userID, "name", surname, birthdate, sex, "profilePicture")
	VALUES(v_userID, arg_name, arg_surname, arg_birthdate, arg_sex, arg_profilePicture);
END; $$ LANGUAGE PLPGSQL

CREATE OR REPLACE PROCEDURE proc_reviewAction(
	arg_rate INT,
	arg_text TEXT,
	arg_photos TEXT,
	arg_userID INT,
	arg_mealID INT,
	OUT r_reviewID INT
)
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM "Review" WHERE userID = arg_userID AND mealID = arg_mealID) THEN
		INSERT INTO "Review"(userID, mealID, "text", "date", rate, photos)
			VALUES(arg_userID, arg_mealID, arg_text, LOCALTIMESTAMP, arg_rate, arg_photos)
		RETURNING reviewID INTO r_reviewID;
	ELSE
		UPDATE "Review"
		SET "text" = arg_text,
			rate = arg_rate,
			photos = arg_photos,
			"date" = LOCALTIMESTAMP
		WHERE userID = arg_userID AND mealID = arg_mealID
		RETURNING reviewID INTO r_reviewID;
		
		DELETE FROM "UserReviewVote" WHERE reviewID = r_reviewID;
	END IF;
END; $$

CREATE OR REPLACE PROCEDURE proc_reviewVoteAction(
	arg_userID INT,
	arg_reviewID INT,
	arg_type BOOLEAN DEFAULT NULL
)
LANGUAGE PLPGSQL
AS $$
BEGIN
	IF arg_type IS NULL THEN
		DELETE FROM "UserReviewVote" WHERE userID = arg_userID AND reviewID = arg_reviewID;
		RETURN;
	END IF;
	
	IF EXISTS (SELECT * FROM "UserReviewVote" WHERE userID = arg_userID AND reviewID = arg_reviewID) THEN
		UPDATE "UserReviewVote"
		SET "type" = arg_type
		WHERE userID = arg_userID AND reviewID = arg_reviewID;
	ELSE
		INSERT INTO "UserReviewVote"(userID, reviewID, "type") VALUES(arg_userID, arg_reviewID, arg_type);
	END IF;
END; $$

CREATE OR REPLACE PROCEDURE proc_followCounts(
	arg_userID INT,
	OUT r_followerCount INT,
	OUT r_followingCount INT
)
AS $$
BEGIN
	SELECT COUNT(*)
	FROM "UserFollow"
	WHERE followingID = arg_userID
	INTO r_followerCount;
	
	SELECT COUNT(*)
	FROM "UserFollow"
	WHERE followerID = arg_userID
	INTO r_followingCount;
END; $$ LANGUAGE PLPGSQL

CREATE OR REPLACE PROCEDURE proc_followAction(
	arg_followerID INT,
	arg_followingID INT,
	OUT r_result VARCHAR(10)
)
AS $$
BEGIN
	IF EXISTS (SELECT * FROM "UserFollow" WHERE followerID = arg_followerID AND followingID = arg_followingID) THEN
		DELETE FROM "UserFollow"
		WHERE followerID = arg_followerID AND followingID = arg_followingID;
		r_result := 'unfollow';
		RETURN;
	END IF;
	
	INSERT INTO "UserFollow"(followerID, followingID)
	VALUES(arg_followerID, arg_followingID);
	
	r_result := 'follow';
END; $$ LANGUAGE PLPGSQL