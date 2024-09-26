USE db;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
SELECT *
FROM users 
JOIN progress
ON users.user_id = progress.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************** **********************
SELECT email_domain, COUNT(user_id) AS "Top 25 schools with most students"
FROM users
GROUP BY email_domain
ORDER BY `Top 25 schools with most students` DESC
LIMIT 25;

-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT COUNT(u.city) AS ".edu learners located in New York"
FROM users u
WHERE u.city LIKE "%New York%";

-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT COUNT(user_id) AS "Mobile app users"
FROM users
WHERE mobile_app LIKE '%mobile-user%';

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT HOUR(sign_up_at) AS "Hour", COUNT(*) AS "Sign up counts for each hour"
FROM users
GROUP BY 1
ORDER BY 2;

-- 6. What courses are the New Yorker Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- ****************************************************************
-- alias p = progress and u = users

SELECT u.city AS "City", 
	SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking C++",
	SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking SQL",
	SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking HTML",
	SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking JAVASCRIPT",
	SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking JAVA"
FROM users u
JOIN progress p
ON u.user_id = p.user_id
WHERE u.city LIKE "New York%"
GROUP BY u.city;



-- 7. What courses are the Chicago Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- ****************************************************************
SELECT u.city AS "City", 
	SUM(CASE WHEN p.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking C++",
	SUM(CASE WHEN p.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking SQL",
	SUM(CASE WHEN p.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking HTML",
	SUM(CASE WHEN p.learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking JAVASCRIPT",
	SUM(CASE WHEN p.learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Learners taking JAVA"
FROM users u
JOIN progress p
ON u.user_id = p.user_id
WHERE u.city LIKE "%Chicago%"
GROUP BY u.city;

-- End of assessment
