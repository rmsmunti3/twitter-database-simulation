-- Twitter Database Simulation Project
-- Created by [Rimas Almuntashiri]
-- Description: Simulates core Twitter functionality (users, profiles, tweets, follows...)
CREATE DATABASE Twitter;
USE Twitter;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password BINARY(64) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    username VARCHAR(50) UNIQUE NOT NULL,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Follows (
    follower_id INT,
    following_id INT,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id),
    FOREIGN KEY (following_id) REFERENCES Users(user_id)
);

CREATE TABLE Tweets (
    tweet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    tweet_id INT,
    user_id INT,
    FOREIGN KEY (tweet_id) REFERENCES Tweets(tweet_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (email, password)
VALUES ('example@email.com', UNHEX(MD5('mypassword')));

DELIMITER //

CREATE PROCEDURE createAccount (
    IN user_email VARCHAR(100),
    IN user_password VARCHAR(100),
    IN user_username VARCHAR(50),
    IN user_bio TEXT
)
BEGIN
	DECLARE new_user_id INT;
    
    INSERT INTO Users (email, password)
    VALUES (user_email, UNHEX(MD5(user_password)));

    SET new_user_id = LAST_INSERT_ID();

    INSERT INTO Profiles (user_id, username, bio)
    VALUES (new_user_id, user_username, user_bio);
END //

DELIMITER ;

SELECT COUNT(*) AS tweet_count
FROM Tweets t
JOIN Profiles p ON t.user_id = p.user_id
WHERE p.username = 'example_user';
