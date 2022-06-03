#1. finding the 5 oldest users 
SELECT username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

#2. Most popular registration date 
SELECT
DAYNAME(created_at) AS day,
COUNT(*) as Total
FROM users
GROUP BY day
ORDER BY Total DESC
LIMIT 2;

#3. find users who have never posted a photo 
SELECT username, image_url
FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.id IS NULL;

#4. query who can get the most likes on a single photo 
SELECT
username,
photos.id,
photos.image_url,
COUNT(*) as Total
FROM photos
INNER JOIN likes
ON likes.photo_id = photos.id
INNER JOIN users
ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

#5 calculate avg number of photos per year 
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

#different approach using join 
SELECT
   COUNT(DISTINCT photos.id) / COUNT(DISTINCT users.id) AS avg_posts_per_user
FROM users
LEFT JOIN photos
ON users.id = photos.user_id;

#6 the top 5 most used hashtags 
select 
tags.tag_name, 
COUNT(*) as total_count
FROM photo_tags
INNER JOIN tags
ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY total_count DESC
LIMIT 5;

#7 find users who liked every single photo on the site 
SELECT
    username,
    user_id,
    COUNT(*) as Total,
    CASE
    WHEN COUNT(*) = 257 THEN 'BOT'
    ELSE 'HUMAN'
    END AS must_be_a_bot
FROM users
INNER JOIN likes
ON users.id = likes.user_id
GROUP BY user_id;

#different approach using having clause
SELECT
    username,
    user_id,
    COUNT(*) as total
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING Total = (SELECT COUNT(*) FROM photos);