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
/* dow is day of week */


/* Lecture 51: Mathematical Functions and Operators
/* rental rate is what percentage of replacement cost*/
SELECT ROUND(rental_rate/replacement_cost*100, 2) AS Percent_Cost FROM film



/*Lecture 52: String and Operators
/* String concatenation - */
SELECT first_name || ' ' || last_name As fullname from customer

/* Create email addresses for all customers */
SELECT Lower(left(first_name, 1) || last_name || 'videostore.com') FROM customer


/* Lecture 53: SubQuery */

/* get list of students and thier grade */
SELECT student, grade FROM test_scores

/* get list of average grades */ 
SELECT AVG(grade) FROM test_scores

/* get list of students that scored above the average grade */
SELECT student, grade FROM test_scores WHERE grade > (SELECT AVG(grade) FROM test_scores)
/* query inside the parentheses is run first providing the result to the remaining query */

/* can use a subquery rather than a join in some cases */
SELECT student, grade FROM test_scores WHERE student IN (SELECT student FROM honor_roll_table)

/* The EXISTS operator is used to test for the exisxtnace of rows in a subquery -- Typically a subquery is passed in the EXITS() function to check is any rows are returned with the subquery */
SELECT column_name FROM table_name WHERE EXISTS (SELECT column_name FROM table_name WHERE condition)
/* returns TRUE or FALSE if any rows would be returned */

/* film titles that have an above average rental rate */
SELECT title FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)

/* film ids and titles that where returned between 5/29/2005 and 5/30/2005 ordered by film id */
SELECT film_id, title 
FROM film 
WHERE film_id IN 
(SELECT inventory.film_id 
 FROM rental 
 Join inventory ON inventory.inventory_id = rental.inventory_id
 WHERE rental.return_date BETWEEN '2005-05-29' AND '2005-05-30')
 ORDER BY film_id

/* customer names where the customer has a single payment greater than $11 */
SELECT first_name || ' ' || last_name AS full_name FROM customer AS c Where EXISTS (SELECT * FROM payment as p WHERE p.customer_id = c.customer_id AND amount > 11) 

/* Lecture 54: Self-join */
/**
Query where a table is joined to itself 
It is useful for comparing values in a columns of rows within the same table. 
Uses same syntax as regular join but with the same table in both parts. 
Must use an alias for the table.
**/

/* Syntax */
SELECT tableA.col, tableB.col FROM table AS tableA JOIN table AS tableB ON tableA.some_col = tableB.other_column

/* find all the pairs of films that have the same length*/
SELECT film1.title, film2.title, film1.length FROM film AS film1 
JOIN film AS film2 ON film1.length = film2.length AND film1.title != film2.title

/* Assessment Test 2 */

/* How can you retrieve all the information from the cd.facilities table? */
SELECT * FROM cd.facilities

/* You want to print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs? */
SELECT name, membercost FROM cd.facilities

/* How can you produce a list of facilities that charge a fee to members? */
SELECT * FROM cd.facilities WHERE membercost > 0

/* How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question. */
SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities WHERE membercost > 0 AND membercost < monthlymaintenance/50.0

/* How can you produce a list of all facilities with the word 'Tennis' in their name? */
SELECT * FROM cd.facilities WHERE name LIKE('%Tennis%')

/* How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator. */

SELECT * FROM cd.facilities WHERE facid IN(1, 5)

/*How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.*/
SELECT memid, surname, firstname, joindate FROM cd.members WHERE joindate >= '2012-09-01'

/* How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates. */
SELECT DISTINCT surname FROM cd.members ORDER BY surname LIMIT 10

/* You'd like to get the signup date of your last member. How can you retrieve this information? */
SELECT MAX(joindate) FROM cd.members 

/* Produce a count of the number of facilities that have a cost to guests of 10 or more. */
SELECT COUNT(*) FROM cd.facilities WHERE guestcost >= 10

/* Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots. */
SELECT facid, SUM(slots) from cd.bookings 
WHERE starttime BETWEEN '2012-09-01' AND '2012-10-01' 
GROUP BY facid ORDER BY SUM(slots)

/* Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id and total slots, sorted by facility id. */
SELECT facid, SUM(slots) FROM cd.bookings GROUP BY facid 
HAVING SUM(slots) > 1000 ORDER BY facid

/* How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time. */
SELECT starttime, name FROM cd.bookings AS book 
JOIN cd.facilities AS fac ON fac.facid = book.facid 
WHERE name LIKE('Tennis%') AND starttime BETWEEN '2012-09-21' AND '2012-09-22'
ORDER BY starttime

/* How can you produce a list of the start times for bookings by members named 'David Farrell'? */
SELECT starttime FROM cd.bookings AS B 
JOIN cd.members AS M ON B.memid = M.memid 
WHERE m.firstname = 'David' AND m.surname='Farrell'

/* Lecture 63 Create Tables */
CREATE TABLE table_name(
  column1 TYPE Options,
  column2 TYPE Options
)

/* create account table */
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY, 
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
)

/* create job table */
CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
)

/* create account_job table */
CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)

/* Lecture 64: Insert data into tables */
INSERT INTO table(column1,column2)
VALUES(value1, value2)

/* Insert data into account table */
INSERT INTO account(username, password, email, created_on)
VALUES
('Jose', 'passowrd','jose@mail.com',CURRENT_TIMESTAMP)

/* Insert into job table */
Insert INTO job(job_name)
VALUES
('President')

/* Insert into account_job table */
INSERT INTO account_job(user_id, job_id, hire_date)
VALUES (1,1,CURRENT_TIMESTAMP)


/* Lecture 65: UPDATE*/
UPDATE table
SET column1 = value1,
    column2 = value2
WHERE 
    condition;

/* update account_job table hire_date column based on user_id */
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id

/* update and provide the updated information */
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login

/* Lecture 66: DELETE */

/* Delete from table based on condition */
DELETE FROM table
WHERE condition

/* Delete based on the presence in other tables */
DELETE FROM tableA
USING tableB
WHERE tableA.id=tableB.id

/* Delete all rows from table */
DELETE FROM table

/* can also use the RETURNING command with DELETE */

/* Lecture 67: ALTER */

/* add new column to table */
ALTER TABLE table_name ADD COLUMN new_col TYPE

/* remove column from table */
ALTER TABLE table_name
DROP COLUMN col_name

/* Alter constraints */
ALTER TABLE table_name
ALTER COLUMN col_name
SET DEFAULT value