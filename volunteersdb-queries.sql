-- Active: 1727243228775@@127.0.0.1@3306@volunteersdb
SELECT * FROM salutations;
SELECT * FROM languages;
SELECT * FROM cities;
SELECT * FROM volunteers;
SELECT * FROM volunteers_languages;
SELECT * FROM volunteer_hours;

-- display the surname, mobile and city from volunteers and cities table
SELECT v.surname, v.mobile, c.city
FROM volunteers v, cities c
WHERE v.city_id = c.id; -- Match v.city_id with c.id

-- display the surname, mobile and city of each volunteer, using a JOIN
SELECT v.surname, v.mobile, c.city
FROM volunteers v
JOIN cities c -- Join statement creates a more efficient way to relate tables with atrributes that relate to one another
ON v.city_id = c.id;

-- display volunteers who live in London
SELECT v.*
FROM volunteers v
JOIN cities c
ON v.city_id = c.id
WHERE c.city = "London";

-- display the surname, mobile and city of each volunteer of those who speak German
-- volunteer + city + languages (volunteers_languages)
SELECT v.surname, v.mobile, l.language
FROM volunteers v
JOIN volunteers_languages vl
ON v.id = vl.volunteer_id
JOIN languages l
ON l.id = vl.language_id
WHERE LOWER(l.language) = "german";

-- displaying surname, mobile and city of volunters who speak German
-- using the LIKE keyword with the wildcard character (%)
SELECT v.surname, v.mobile, l.language
FROM volunteers v
JOIN volunteers_languages vl
ON v.id = vl.volunteer_id
JOIN languages l
ON l.id = vl.language_id
WHERE LOWER(l.language) = "german"; -- or WHERE l.language LIKE '%German%';

-- Displaying surname, mobile and city of volunteers who speak German
-- Using the LIKE keyword with the wildcard character %
SELECT v.surname, v.mobile, l.language
FROM volunteers v
JOIN volunteers_languages vl
ON v.id = vl.volunteer_id
JOIN languages l
ON l.id = vl.language_id
WHERE l.language LIKE "%German"; -- if just Eng% - it looks for query starting with Eng
                                -- if %Ger, it looks for words ending with -ger

-- display volunteer number in their specific city
-- using COUNT() aggregate function, GROUP BY must be used
-- using ORDER BY to list the data in ASC or DESC order (default, ASCENDING)
SELECT COUNT(v.city_id) AS "Number of Volunteers", c.city
FROM volunteers v
JOIN cities c
ON v.city_id = c.id
GROUP BY v.city_id
ORDER by c.city;

-- display the number of distinct cities from volunteers
SELECT COUNT(DISTINCT c.city) AS "Number of Cities"         -- Distinct keyword prevents duplicates
FROM volunteers v
JOIN cities c
ON v.city_id = c.id;

-- display the distinct languages spoken by volunteers
SELECT DISTINCT(l.language)
FROM volunteers_languages vl
JOIN languages l
ON vl.language_id = l.id;

-- display the volunteer who speaks the most languages
SELECT MAX(l.language) AS "Most Spoken Language"
FROM volunteers_languages vl
JOIN languages l
ON vl.language_id = l.id;

-- display the least spoken langauge amongst volunteers
SELECT MIN(l.language) AS "Least Spoken Language"
FROM volunteers_languages vl
JOIN languages l
ON vl.language_id = l.id;

-- display the total volunteered hours per volunteer
SELECT v.surname, SUM(vh.hours) AS "Volunteered Hours"
FROM volunteer_hours vh 
JOIN volunteers v 
ON vh.volunteer_id = v.id 
GROUP BY v.surname 
ORDER BY `Volunteered Hours` ASC;  
-- must use back ticks to get it in DESC or ASC order.


-- display the average volunteered hours per volunteer
SELECT v.surname AS "Volunteer ID", AVG(vh.hours) AS "Average Volunteered Hours"
FROM volunteers v 
JOIN volunteer_hours vh 
ON v.id = vh.volunteer_id
GROUP BY `Surname`
ORDER BY `Average Volunteered Hours` DESC; 

-- display the most hours worked by a volunteer
SELECT v.surname, MAX(vh.hours) AS "Most Hours Worked"
FROM volunteer_hours vh 
JOIN volunteers v 
ON v.id = vh.volunteer_id
GROUP BY v.surname
ORDER BY `Most Hours Worked` DESC;

-- display the least hours worked by a volunteer
SELECT v.surname, MIN(vh.hours) AS "Least Hours Worked"
FROM volunteer_hours vh 
JOIN volunteers v 
ON v.id = vh.volunteer_id
GROUP BY v.surname
ORDER BY `Least Hours Worked`;

-- display the cumulative volunteer hours from all volunteers
SELECT SUM(`Total Hours Volunteered`) AS "Cumulative Volunteer Hours"
FROM(
    SELECT SUM(vh.hours) as "Total Hours Volunteered"
    FROM volunteers v 
    JOIN volunteer_hours vh 
    ON v.id = vh.volunteer_id
    GROUP BY vh.volunteer_id
) AS Cumulative;

-- or use this method
SELECT SUM(hours) AS "Cumulative Volunteer Hours"
FROM volunteer_hours;

-- display the occassion each volunteer put up ore than 10 hours per visit
SELECT 
v.surname,
SUM(CASE WHEN vh.hours > 10 THEN 1 ELSE 0 END) AS "Occasions volunteered hours > 10"    -- condition
FROM volunteers v 
JOIN volunteer_hours vh 
ON v.id = vh.volunteer_id
GROUP BY v.surname;



-- display the ocassion each volunteer 
-- *************************************************************


