/* Find All actors */ 
SELECT * FROM actor;

/* find all films */
SELECT * FROM film;

/* fiind first and last names and email addresses of every customer*/
SELECT * from customer;

/***********************************************
/* Section 2: SQL Fundementals */
/***********************************************

/***********************************************
/* Lecture 13: SELECT Challenge
Use a SELECT statement to grab the first and last name and email address of every customer */
SELECT first_name, last_name, email FROM customer;

/***********************************************
/* Lecture 15: SELECT DISTINCT Challenge
What ratings do we have available in our database? */
SELECT DISTINCT rating FROM film;

/***********************************************
/* Lecture 19: SELECT WHERE Challenge
What is the email of the customer with the name Nancy Thomas
*/

SELECT email FROM customer WHERE first_name = 'Nancy' AND last_name = 'Thomas';

/* What is the description for the movie 'Outlaw Hankey'? */
SELECT description FROM film WHERE title = 'Outlaw Hankey';

/* Provide the phone number for the customer that lives at '259 Ipoh Drive' */
SELECT phone FROM address WHERE address = '259 Ipoh Drive';

/***********************************************
/* Lecture 22: ORDER BY Challenge */
/* What are the customer ids of the first 10 customers who created payments? */
SELECT customer_id FROM payment ORDER BY payment_date ASC LIMIT 10;

/* What are the titles of the five shortest (in length runtine) movies? */
SELECT title, length FROM film ORDER BY length ASC LIMIT 5;

/* If the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have? */
SELECT COUNT(*) FROM film WHERE length <= 50;

/***********************************************
/* Lecture 26: General Challenge 1 */
/* How many payment transactions were greater than $5.00? */
SELECT COUNT(amount) FROM payment WHERE amount > 5;

/* How many actors have a first name that starts with the letter P? */
SELECT COUNT(first_name) FROM actor WHERE first_name LIKE 'P%';

/* How many unique districts are our customers from? */
SELECT COUNT(DISTINCT(district)) FROM address;

/* Retrieve the list of names for those distinct districts from the previous question. */
SELECT DISTINCT(district) FROM address;

/* How many films have a rating of R and a replacement cost between $5.00 and $15.00 */
SELECT COUNT(*) FROM film WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

/* How many films have the work Truman somewhere in the title? */
SELECT COUNT(*) from film WHERE title LIKE '%Truman%';

/***********************************************
/* Section 3: GROUP BY Statements 
/***********************************************

Lecture 31: GROUP BY Challenge
Of the two staff members (ID 1 and ID 2), who handled the most payments?
*/
SELECT staff_id, COUNT(staff_id) FROM payment GOUP BY staff_id

/* What is the average replacement cost per movie rating? */
SELECT rating, AVG(replacement_cost) FROM film GROUP BY rating

SELECT rating, ROUND(AVG(replacement_cost),2) FROM film GROUP BY rating

/* What are the customer ids of the top 5 customers by total spent? */
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5;

/***********************************************
Lecture 33: HAVING Challenge 
/* Which customer_ids have greater than 40 transactions?*/
SELECT customer_id, COUNT(customer_id) FROM payment GROUP BY customer_id HAVING COUNT(customer_id) >= 40;

/* What are the customer ids of customers who have spent more than $100 in payment transactions with our staff_id member 2? */
SELECT customer_id, SUM(amount), staff_id FROM payment GROUP BY customer_id, staff_id HAVING staff_id = 2 AND SUM(amount) > 100;

SELECT customer_id, SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id Having SUM(amount)>100;

/***********************************************
/* Section 4: Assessment Test 1 
/***********************************************

1. Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.*/
SELECT customer_id, SUM(amount), staff_id FROM payment GROUP BY customer_id, staff_id HAVING staff_id = 2 AND SUM(amount) >= 110;
/*The answer should be customers 187 and 148.

2. How many films begin with the letter J?
*/
SELECT COUNT(title) FROM film WHERE title LIKE 'J%';
/* The answer should be 20. 

3. What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
*/
SELECT customer_id, first_name, last_name FROM customer WHERE first_name LIKE 'E%' AND address_id < 500 ORDER BY customer_id DESC LIMIT 1
/* The answer is Eddie Tomlin */


/***********************************************
/* Section 5: Join Challenges */
/***********************************************
Lecture 39: As Operator - gets executed at the end of a query providing an alias to use inside the WHERE operator */
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
/* 
* - puts total_spent at the top of the output column 
* - cannot put the total_spent in the HAVING Clause or a WHERE statment because it has not been assigned until the end */

/***********************************************
Lecture 40: Inner Joins
* - allows us to join multiple table information by using a common column
* - Inner Joins combine two tables and output the records that MATCH IN BOTH tables */

SELECT * FROM table1 INNER JOIN table2 ON table1.matching_column = table2.matching_column

/* If we are selecting a column from the join table we have to specify that by indicating the table_name.column_name */
SELECT col1, col2, table2.col3 FROM table1 INNER JOIN table2 ON table1.matching_column = table2.matching_column

/* Table order does not matter with inner join. */

SELECT payment_id, payment.customer_id, first_name, last_name, email
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

/* Only need to specify the table when the column name is used in both tables */
/***********************************************
Lecture 41: Full Outer Joins
Merge two tables into one including all of the information in both tables */
SELECT * FROM table1 FULL OUTER JOIN table2 ON table1.matching_column = table2.matching_column

/* Find all the values that do not match (i.e. would not be included in an INNER JOIN) */
SELECT * FROM table1 
FULL OUTER JOIN table2 
ON table1.matching_column = table2.matching_column
WHERE table1.id IS null OR table2.id IS null


/* Return a list of values where the customer has never made a payment or the payment is not assigned to a customer */
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null 
OR payment.customer_id IS null

/***********************************************
Lecture 42: Left Outer Joins
Results conatian all the records from the left table.  Records are included from the right table and if there is no matching record in the right table the results will be null */

/* ORDER MATTERS - the first table (left) is the table that will be included and the right table will only provide data where there is a match. */
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.matching_column = table2.matching_column

/* What is we want to include only unique entries to table1? */
SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.matching_column = table2.matching_column WHERE table2.id IS null

/* Examples */
/*  List of movies that are not currently in inventory */
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory 
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS null

/***********************************************
Lecture 43: Right Joins
/* Right joins flip the table order but everything else is the same - i.e. a left join could be used if you just switch the order of the FROM and JOIN statements */
SELECT * FROM table2 RIGHT OUTER JOIN table1 ON table2.matching_column = table1.matching_column

/* is the same as */

SELECT * FROM table1 LEFT OUTER JOIN table2 ON table1.matching_column = table2.matching_column
/***********************************************
Lecture 44: Union
UNION is used to combine the result-set of two or more SELECT statements.  It directly concatenates two results together into one table. */

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2

/* Should only be used where the information iin the tables should match up */

/***********************************************
Lecture 45: Join Challenges

/* What are the emails of the customers that live in California? */

SELECT * FROM address WHERE district = 'California'  /*address.id*/
SELECT email FROM customer /*email*/

/* Solution */

SELECT district, email FROM address INNER JOIN customer ON address.address_id = customer.address_id WHERE district = 'California' 

/* Get a list of the movies that "Nick Wahlberg" has been in. */
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Mark' AND last_name = 'Wahlberg'

SELECT actor_id, film_id FROM film_actor /* start with join table */

SELECT title FROM film /* film titles */

/* Solution */

SELECT actor.first_name, actor.lastname, film.title 
FROM film_actor 
  INNER JOIN actor 
  ON film_actor.actor_id = actor.actor_id
  INNER JOIN film
  ON film_actor.film_id=film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg' 

/***********************************************
/* Section 6: Advanced SQL Commands */
/***********************************************/
SHOW ALL /* shows all the current PostgreSQL settings */

SELECT NOW() /* provides numeric time value with adjustment to GMT */

SELECT TIMEOFDAY() /* shows the current time in text format  with abbreviated time zone*/

SELECT CURRENT_TIME /* provides numeric time */

SELECT CURRENT_DATE /* provides date in YYYY-MM-DD format */ 

/* EXTRACT() - extracts a sub-component of a date value 
YEAR
MONTH
DAY 
WEEK
QUARTER
*/

EXTRACT(YEAR FROM date_col) /* extracts a sub-component (YEAR) of the date column */

/* AGE() - calculates and returns the current age gven a timestamp */

AGE(date_col) /* calculates how old the timestamp provided if compared to today's date */ 

/* TO_CHAR() - converts data types to text */
TO_CHAR(date_col, 'mm-dd-yyyy')

/* list all the payment years */
SELECT EXTRACT(YEAR FROM payment_date) AS Year
FROM payment

/* list all the payment quarters */ 
SELECT EXTRACT(QUARTER FROM payment_date) AS pay_quarter
FROM payment

/* How much time has passed since the payment occurred */
SELECT AGE(payment_date) AS payment_age
FROM payment

/* print the date the payment was made in text format of MM-DD-YY */
SELECT TO_CHAR(payment_date, 'mm-dd-yyyy') AS payment_text
FROM payment

/* Prints the month in all caps and the year as thousands */
SELECT TO_CHAR(payment_date, 'MONTH-YYYY')
FROM payment

/* Lecture 50: Challenge Tasks */
/* During what months did payments occur? Format the answer to return the full month name. */
SELECT TO_CHAR(payment_date, 'Month') AS month
FROM payment
GROUP BY month

SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH'))
FROM payment

/* How many payments occured on a Monday? */
SELECT COUNT(payment_id)
FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1









