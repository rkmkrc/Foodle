CREATE TABLE "UserCredentials" (
	userID INT,
	username VARCHAR(32) UNIQUE NOT NULL,
	email VARCHAR(256),
	phoneNumber CHAR(13),
	hashedPassword VARCHAR(128),
	accessToken VARCHAR(128) UNIQUE,
	PRIMARY KEY(userID)
);

CREATE TABLE "UserInfo" (
	infoID INT,
	userID INT,
	"name" VARCHAR(256),
	surname VARCHAR(256),
	birthdate DATE,
	sex CHAR(1),
	score INT,
	PRIMARY KEY(infoID),
	FOREIGN KEY(userID) REFERENCES "UserCredentials"(userID)
);

CREATE TABLE "UserFollow" (
	followerID INT,
	followingID INT,
	PRIMARY KEY(followerID, followingID),
	FOREIGN KEY(followerID) REFERENCES "UserCredentials"(userID),
	FOREIGN KEY(followingID) REFERENCES "UserCredentials"(userID)
);

CREATE TABLE "Restaurant" (
	restaurantID INT,
	"name" VARCHAR(256),
	latitude REAL,
	longitude REAL,
	"location" VARCHAR(256),
	"type" varchar(32),
	score INT,
	PRIMARY KEY(restaurantID)
);

CREATE TABLE "Meal" (
	mealID INT,
	restaurantID INT,
	"name" varchar(256),
	description TEXT,
	foodContent TEXT,
	price REAL CONSTRAINT mealPriceNonNegative CHECK (price > 0),
	PRIMARY KEY(mealID),
	FOREIGN KEY(restaurantID) REFERENCES "Restaurant"(restaurantID)
);

CREATE TABLE "Review" (
	reviewID INT,
	userID INT,
	mealID INT,
	"text" TEXT,
	"date" DATE,
	rate SMALLINT NOT NULL,
	score INT,
	photos TEXT,
	PRIMARY KEY(reviewID),
	FOREIGN KEY(userID) REFERENCES "UserCredentials"(userID),
	FOREIGN KEY(mealID) REFERENCES "Meal"(mealID)
);

CREATE TABLE "UserReviewVote" (
	reviewID INT,
	userID INT,
	"type" bit,
	PRIMARY KEY(reviewID, userID),
	FOREIGN KEY(reviewID) REFERENCES "Review"(reviewID),
	FOREIGN KEY(userID) REFERENCES "UserCredentials"(userID)
);