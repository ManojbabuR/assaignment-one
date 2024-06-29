## 1. Identify the five oldest users on Instagram from the provided data base
use ig_clone;
select* from users;
select username,created_at from users order by created_at limit 5;


## 2. Identify users who have never posted a single photo on Instagram.
select* from photos,users;
select* from users u left join photos p on p.user_id=u.id where p.image_url is null order by u.username;

## 3. Determine the winner of the contest and provide their details to the team

select * from likes,photos,users;
SELECT
username,photos.id,photos.image_url, count(likes.user_id) as total
FROM photos
INNER JOIN likes
ON likes.photo_id=photos.id
INNER JOIN users
ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1; 

## 4 Identify and suggest the top five most commonly used hashtags on the platform.

SELECT
tags.tag_name,
Count(*) AS total
FROM photo_tags
JOIN tags
ON photo_tags.tag_id= tags.id
GROUP BY tags.id
ORDER BY total DESC;

## 5 Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

SELECT
DAYNAME(created_at) AS day, count(*) as total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

## 6 Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.

SELECT
(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

## 7 Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.

SELECT user_id, Count(*) as num_likes
FROM likes
GROUP BY user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);
SELECT u.username, COUNT(*) as num_likes
FROM users u
JOIN likes l on u.id = l.user_id
GROUP BY u.id
HAVING num_likes = (SELECT COUNT(*) FROM photos);








