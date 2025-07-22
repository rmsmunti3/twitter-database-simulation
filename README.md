# Twitter SQL Database Project
## Description
This is a **SQL simulation** of a basic Twitter-like social media platform. It includes users, their profiles, tweets, likes, and follow relatioships. The project demonstrates database design, table relationships, encryption, procedures, indexing, and advanced SQL concepts.
> This project was developed as the **final project** for the **SQL course on the Satr platform (منصة سطر)**
---
## Features
- **User registration with password encryption**
- **User profiles with bio and username**
- **Tweet creation and timestamping**
- **Like fonctionality (many-to-many: users <-> tweets)**
- **Follow system (many-to-many: users <-> users)**
- **Stored procedure for user registration and follow**
- **Auto-increment IDs and relational constraints**
- **Use of MD5 encryption with UNHEX**
- **Indexing by username for faster search**
---
## Tables Overview
| Table       | Description |
| 'User'      | Contains email, encrypted password, and creation time |
| 'Profiles'  | One-to-One profile with username and bio              |
| 'Tweets'    | Each tweet belongs to a user                          |
| 'Likes'     | Tracks likes (user <-> tweet)                         |
| 'Follows'   | Traks follow relationships (user <-> user)            |
---
## ER Diagram
- This project uses an ERD diagram built with [drawSQL](https://drawsql.app).
- It demonstrates 1:1, 1:N, and N:M relationships between tables.
---
## Stored Procedures
- 'createAccount(user_email, user_password, user_username, user_bio)' -> Inserts new user into 'User', and creates matching 'Profiles'.
- 'User_Follow(current_username, target_username)' -> Adds a follow relationship based on usernames.
---
## Sample Query
'''sql
SELECT COUNT(*) AS tweet_count
FROM Tweets t
JOIN Profiles p ON t.user_id = p.user_id
WHERE p.username = 'example_user';
