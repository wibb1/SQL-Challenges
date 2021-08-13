/*
The CITY table is described as follows:
Field           Type
-----------------------
ID              NUMBER
NAME            VARCHAR2(17)
COUNTRYCODE     VARCHAR2(3)
DISTRICT        VARCHAR2(20)
POPULATION      NUMBER
*/

/* REVISING THE SELECT QUERY I 
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
*/
SELECT * FROM CITY WHERE POPULATION>100000 AND COUNTRYCODE='USA'

/* REVISING THE SELECT QUERY II
Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
*/
SELECT NAME FROM CITY WHERE POPULATION>120000 AND COUNTRYCODE='USA'

/* SELECT ALL
Query all columns (attributes) for every row in the CITY table.
*/
SELECT * FROM CITY

/* SELECT BY ID
Query all columns for a city in CITY with the ID 1661.
*/
SELECT * FROM CITY WHERE ID=1661

/* Japanese Cities' Attributes
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
SELECT * FROM CITY WHERE COUNTRYCODE='JPN'

/* JAPANESE CITIES' NAMES
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
*/
SELECT NAME FROM CITY WHERE COUNTRYCODE='JPN'

/*
STATION
------------------------
FIELD             TYPE
------------------------
ID                NUMBER
CITY              VARCHAR(21)
STATE             VARCHAR(2)
LAT_N             NUMBER
LONG_W            NUMBER
*/

/* WEATHER OBSERVATIONS 1
Query a list of CITY and STATE from the STATION table.
*/

SELECT CITY, STATE FROM STATION

/* WEATHER OBSERVATIONS 3
Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
*/
SELECT DISTINCT CITY FROM STATION WHERE ID%2=0

/* WEATHER OBSERVATIONS 4
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
*/
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)FROM STATION;

/* WEATHER OBSERVATIONS 6
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(CITY, '^[AEIOU]', 'i');

/* WEATHER OBSERVATIONS 7
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(CITY, '[AEIOU]$', 'i');

/* WEATHER OBSERVATIONS 8
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(CITY, '^[AEIOU].*[AEIOU]$', 'i');

/* WEATHER OBSERVATIONS 9
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE NOT REGEXP_LIKE(CITY, '^[AEIOU]', 'i');

/* WEATHER OBSERVATIONS 10
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE NOT REGEXP_LIKE(CITY, '[AEIOU]$', 'i');

/* WEATHER OBSERVATIONS 11
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE NOT REGEXP_LIKE(CITY, '^[AEIOU].*[AEIOU]$', 'i');

/* WEATHER OBSERVATIONS 12
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY FROM STATION WHERE NOT REGEXP_LIKE(CITY, '^[AEIOU]', 'i') AND WHERE NOT REGEXP_LIKE(CITY, '[AEIOU]$', 'i');


/*
The STUDENTS table is described as follows:  The Name column only contains uppercase (A-Z) and lowercase (a-z) letters.
--------------------------
STUDENTS TABLE
COLUMN          TYPE
--------------------------
ID              INTEGER
NAME            STRING
MARKS           INTEGER
--------------------------

--------------------------
Sample Input
ID  NAME      MARKS
--------------------------
1   ASHLEY      81
2   SAMANTHA    75
4   JULIA       76
3   BELVET      84
--------------------------
*/

/* HIGHER THAN 75 MARKS
Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/
SELECT NAME FROM STUDENTS WHERE MARKS>75 order by right(name, 3), id asc;

/* EMPLOYEE NAMES
Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

Input Format

The Employee table containing employee data for a company is described as follows:

COLUMN        TYPE
employee_id   Integer
name          String
months        Integer
salary        Integer

where employee_id is an employee's ID number, name is their name, months is the total number of months they've been working for the company, and salary is their monthly salary.
-----------------------------------------
Sample Input
-----------------------------------------
employee_id   name    months      salary
12228         Rose      15         1968
33645         Angela    1          3443        
45692         Frank     17         1608      
56118         Patric    7          1345           
59725         Lisa      11         2330                    
74197         Kimberly  16         4372        
78454         Bonnie    8          1771
83565         Michael   6          2017 
98607         Todd      5          3396 
99989         Joe       9          3574 

-----------------------------------------
Sample Output
-----------------------------------------
Angela
Bonnie
Frank
Joe
Kimberly
Lisa
Michael
Patrick
Rose
Todd
*/
select name from employee order by name asc

/*
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
*/
select name from employee where salary>2000 AND months<10 order by employee_id asc

/*/   African Cities   
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
/*/
SELECT CITY.NAME FROM CITY INNER JOIN COUNTRY ON CITY.CountryCode = COUNTRY.CODE WHERE continent='Africa' 

/*/  Average Population of Each Continent  /*/
select country.continent, floor(avg(city.population)) from city inner join country on country.code=city.countrycode group by country.continent;


/*/ The Report  /*/

SELECT IF(G.Grade<8, NULL, S.Name), S.Marks, G.Grade FROM STUDENTS AS S JOIN GRADES AS G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark ORDER BY G.Grade DESC, S.Name, S.Marks;


/*********************************/
/* SWITCHED TO MEDIUM DIFFICULTY */
/*********************************/

/*/
Top Competitors - Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

-------------------------
HACKERS
-------------------------
hacker_id         name
integer           String
-------------------------

-------------------------
Difficulty
-------------------------
difficulty_level  score
Integer           Integer
-------------------------


--------------------------------------------
Challenges
--------------------------------------------
challenge_id    hacker_id   difficulty_level
Integer         Integer     Integer
--------------------------------------------


SUMMARY 
-------------------------
OUTPUT - HACKERS.hacker_id, HACKERS.name, 
SORT - who achieved full scores for more than one challenge
ORDER BY - DESC by total challenges with full score then by ASC hacker_id

INCOMPLETE/*/ 
SELECT Challenges.difficulty_level, Challenges.challenge_id AS C, Submissions.challenge_id, Submissions.submission_id, Submissions.score, Submissions.hacker_id AS S, Hacker.hacker_id, Hacker.name AS H,



/*/ Olivander's Inventory
Print wand id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 

Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 

If more than one wand has same power, sort the result in order of descending age.

Wands
------------------------
column          type
id              Integer
code            Integer
coins_needed    Integer
power           Integer

Wands_Property
------------------------
column          type
code            Integer
age ie_evil     Integer


Sample Output
------------------------
9 45 1647 10
12 17 9897 10
1 20 3688 8
15 40 6018 7
19 20 7651 6
11 40 7587 5
10 20 504 5
18 40 3312 3
20 17 5689 3
5 45 6020 2
14 40 5408 1


SUMMARY
-----------
* no evil wands
* join wands and wands_property using code where wands_property is_evil=0
* sort by decsending power then by age
* print the id, age, coins_needed, and power of the wands


SCode
----------
SELECT
Wands_Property, FROM Wands_Property WHERE Wands_Property.is_evil = 0 AS P
JOIN Wands ON P.code = Wands.code
ORDER BY P.power DESC, P.age

/*/
SELECT Wands.id, Wands_Property.age, Wands.coins_needed, Wands.power FROM Wands JOIN Wands_Property ON Wands_Property.code=Wands.code WHERE Wands_Property.is_evil=0 AND Wands.coins_needed = (SELECT MIN(coins_needed) FROM Wands AS W JOIN Wands_Property AS P ON W.code=P.code WHERE W.power=Wands.power AND P.age=Wands_Property.age) ORDER BY Wands.power DESC, Wands_Property.age DESC;



SELECT W.ID, P.AGE, W.COINS_NEEDED, W.POWER 
FROM WANDS AS W
JOIN WANDS_PROPERTY AS P
ON (W.CODE = P.CODE) 
WHERE P.IS_EVIL = 0 AND W.COINS_NEEDED = (SELECT MIN(COINS_NEEDED) 
                                          FROM WANDS AS X
                                          JOIN WANDS_PROPERTY AS Y 
                                          ON (X.CODE = Y.CODE) 
                                          WHERE X.POWER = W.POWER AND Y.AGE = P.AGE) 
ORDER BY W.POWER DESC, P.AGE DESC;


/*/Challenges
Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

Input Format

The following tables contain challenge data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.
--------------------
column        type
--------------------
hacker_id     Iteger

Challenges: The challenge_id is the id of the challenge, and hacker_id is the id of the student who created the challenge.
--------------------
Column        Type
---------------------
challenge_id  Integer
name          String

SUMMARY
RETURN = hacker_id, name, and the total number of challenges created by each student

SORT BY = total challenges DESC then by hacker_id
/*/









/*
Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.

Input Format

The OCCUPATIONS table is described as follows:  Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input

An OCCUPATIONS table that contains the following records:

Name      Occupation
-----------------------
String    String
-----------------------
Samantha  Doctor
Julia     Actor
Maria     Actor
Meera     Singer
Ashley    Professor
Ketty     Professor
Christeen Professor
Jane      Actor
Jenny     Doctor
Priya     Singer

Sample Output

Ashely(P)
Christeen(P)
Jane(A)
Jenny(D)
Julia(A)
Ketty(P)
Maria(A)
Meera(S)
Priya(S)
Samantha(D)
There are a total of 2 doctors.
There are a total of 2 singers.
There are a total of 3 actors.
There are a total of 3 professors.
*/
select concat(Name, '(', substr(Occupation,1,1),')') from occupations order by name;
select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.') from occupations group by occupation order by count(occupation), occupation;

/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.
*/

select Name as name_sorted_by_occupation, Name from ()

