/*/

spend at most 
* 50,0000 2018 or later
* 20,000 2010 or later

write an sql query that returns a table of ids that meet the requirements

/*/

SELECT id FROM CARS WHERE (price<=50000 AND year>=2018) OR (price<=20000 AND year>=2010) ORDER BY id ASC


SELECT id FROM CARS WHERE (price<=50000 AND condition='New' AND year>=2018) OR (price<=20000 AND condition='Used' AND year>=2010) ORDER BY id ASC



  create table test_groups (
      name varchar(40) not null,
      test_value integer not null,
      unique(name)
  );

  create table test_cases (
      id integer not null,
      group_name varchar(40) not null,
      status varchar(5) not null,
      unique(id)
  );

SELECT test_groups.group_name, test_groups.test_value, SUM(all_test_cases), SUM(passed_test_cases), SUM(total_value) FROM test_groups ODER BY total_value DESC, test_groups.group_name DESC



SELECT COALESCE(MAX(overlap.sum), 0) booked
FROM (
  SELECT COALESCE(SUM())
)

FROM meetings WHERE start_time BETWEEN ()