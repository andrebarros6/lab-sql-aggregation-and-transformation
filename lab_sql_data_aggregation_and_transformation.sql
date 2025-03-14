/*Challenge 1
1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.*/
#1.1
SELECT MAX(length) AS max_duration FROM film;
SELECT MIN(length) AS min_duration FROM film;
#1.2 
SELECT FLOOR(AVG(length)/60) as hours
FROM film;
SELECT ROUND(((AVG(length)/60)-1)*60, 0) AS minutes
FROM film;

/* 2. You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column 
from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
depending on the day of the week.
Hint: use a conditional expression.*/
#2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date) ) AS date
FROM rental;

#2.2
SELECT *,
	   DATE_FORMAT (rental_date, '%M') AS month,
	   DATE_FORMAT (rental_date, '%W') AS weekday
FROM rental
LIMIT 20;

#2.3 
SELECT *, DATE_FORMAT (rental_date, '%w') AS weekday,
	CASE 
		WHEN DATE_FORMAT (rental_date, '%w') IN (1,2,3,4,5) THEN 'workday'
        ELSE 'weekend'
        #WHEN DATE_FORMAT (rental_date, '%w') IN (0,6) THEN
        END AS DAY_TYPE
FROM rental;


/* 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the 
film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written
to handle such cases in the future.
Hint: Look for the IFNULL() function.*/

/* this would also work but is not using ifnull
SELECT title,  
	CASE 
		WHEN rental_duration = NULL THEN 'Not Available' #IFNULL(NULL, 'Not Available')
        ELSE rental_duration
        END AS rental_duration1
FROM film
ORDER BY title ASC;*/

SELECT title,  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


/* 4. Bonus:The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of 
their email address, so that you can address them by their first name and use their email address to send personalized 
recommendations. The results should be ordered by last name in ascending order to make it easier to use the data. */

