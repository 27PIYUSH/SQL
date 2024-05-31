-- not a case sensitive language

-- Syntax:::
-- CREATE DATABASE db_name;
-- CREATE DATABASE IF NOT EXISTS db_name --> good way
-- DROP DATABASE db_name;
-- DROP DATABASE IF NOT EXISTS db_name; --> good way

CREATE DATABASE IF NOT EXISTS college;
USE college;

-- CREATE:::
-- CREATE TABLE table_name(
-- coloumn_name1 datatype constraint,
-- coloumn_name2 datatype constraint
-- );  

CREATE TABLE student(
  S_id INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT NOT NULL
);

-- INSERT:::
-- INSERT INTO table_name VALUES(column1 value, column2 value);
-- INSERT INTO table_name(fname,lname) 
-- VALUES
-- (f1,l1),
-- (f2,l2);

INSERT INTO student VALUES(1,"RAM",17);
INSERT INTO student(Name,Age) 
VALUES
	("Aman",19),
  ("Keshav",17),
  ("Naman",18),
  ("Tushara",18);
    
-- SAFE MODE::: by default ON
SET SQL_SAFE_UPDATES = 0; -- to turn off safe mode

-- UPDATE:::
-- UPDATE table_name SET col = value WHERE condition;
UPDATE student SET Age = 16 WHERE S_id = 1; 

-- DELETE::: to delete existing rows
-- DELETE FROM table_name WHERE condition; 
DELETE FROM student WHERE name = "Naman";

-- Datatypes::: 
-- CHAR , VARCHAR , BLOB , INT , TINYINT , BIGINT , BIT , FLOAT , DOUBLE , BOOLEAN , DATE , YEAR
-- SIGNED & UNSIGNED --> TINYINT UNSIGNED (0 TO 255) , TINYINT (-128 TO 127){SIGNED can store both negative and positive values}

-- Types of SQL Commands:::
-- DDL : CREATE , ALTER , RENAME , TRUNCATE & DROP 
-- DQL : SELECT
-- DML : INSERT , UPDATE & DELETE
-- DCL : GRANT & REVOKE permission to users
-- TCL : START TRANSACTION , COMMIT , ROLLBACK

SHOW DATABASES;
SHOW TABLES;

-- KEYS:::
-- PRIMARY KEY, FOREGIN KEY, SUPER KEY, CANDIDATE KEY, COMPOSITE KEY, ALTERNATE KEY

-- CONSTRAINTS:::
-- NOT NULL --> cannot have a null value
-- UNIQUE --> all values in a column are different
-- PRIMARY KEY --> makes a column unique and not null 
-- FOREGIN KEY --> prevent actions that would destroy links b/w tables 
-- DEFAULT --> sets the default value of the colunmn
-- CHECK --> it can limit the values allowed in a column


-- SELECT:::
-- SELECT * FROM table_name --> Select and view all columns
-- SELECT col1 , col2 FROM table_name;
SELECT * FROM student;
SELECT S_id,name FROM student;

-- WHERE clause::: SELECT col1 , col2 FROM table_name WHERE conditions;
-- Operators : 1) Arithmetic : +, -, *, /, %
		    -- 2) Comparision : =, !=, >, <, <=, >=
            -- 3) Logical : AND , OR , NOT , IN , BETWEEN , ALL , LIKE , ANY
            -- 4) Bitwise : & , | 
SELECT S_id,name FROM student where age>18;
SELECT * FROM student where age<18 AND name = "ram";

-- LIMIT Clause::: sets an upper limit on no. of tuples to be returned
SELECT * FROM student LIMIT 2;

-- ORDER BY Clause::: to sort in ascending or descending order (asc , desc)
SELECT * FROM student ORDER BY name ASC;

-- AGGREGATE FUNCTIONS::: performs a calculations on set of values and return a single value
-- MAX()
SELECT max(age) FROM student;

-- MIN()
SELECT min(age) FROM student;

-- SUM()
SELECT sum(age) FROM student;

-- AVG()
SELECT avg(age) FROM student;

-- COUNT()
SELECT count(name) FROM student;

-- GROUP BY Clause::: group rows that have same values into summary rows 
-- it collects data from multiple records and groups the result by one or more column 
-- generally it is used with aggregate function

-- EX: count no. of student in different age groups
SELECT age ,count(name) FROM student GROUP BY age;

-- HAVING Clause::: similar to where clause , where --> rows , having --> group
-- used when we want to apply condition after grouping
SELECT count(name),age FROM student GROUP BY age HAVING age>17;

-- GENERAL ORDER::: 
-- SELECT column 
-- FROM table_name
-- WHERE condition
-- GROUP BY column
-- HAVING condition
-- ORDER BY column ASC
SELECT age FROM student WHERE s_id>0 GROUP BY age HAVING min(age)>17 ORDER BY age ASC;

-- REVISITING FK:::
CREATE TABLE dept(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE teacher(
	id INT PRIMARY KEY,
    name VARCHAR(30),
    Dept_id INT ,
    FOREIGN KEY (dept_id) REFERENCES dept(id)
    ON UPDATE CASCADE  -- also affect the refrenced row in the child 
    ON DELETE CASCADE  -- also affect the refrenced row in the child 
);

INSERT INTO dept(id,name) VALUES (67,"ECE") , (69,"CSE DS") , (56,"CSE AIML");

INSERT INTO teacher(id,name,dept_id) VALUES (675,"Raman",67),(543,"Ravi",69) , (453,"Saurabh",56);
select * from teacher;
select * from dept;
UPDATE dept SET id = 70 WHERE id = 67;

-- ALTER:::

-- ADD Columnn - ALTER TABLE table_name ADD COLUMN column_name datatype constraints;
ALTER TABLE teacher ADD COLUMN age INT NOT NULL;

-- DROP Column -  ALTER TABLE table_name DROP COLUMN column_name;
ALTER TABLE teacher DROP COLUMN age;

-- RENAME Table -  ALTER TABLE table_name RENAME TO new_table_name;
ALTER TABLE teacher RENAME TO Professors;

-- CHANGE Column - (rename) ALTER TABLE table_name CHANGE COLUMN old_name new_name new_datatype new_constraint; 
ALTER TABLE dept CHANGE COLUMN name dept_name VARCHAR(50); 

-- MODIFY Column - (modify datatype/constraint) ALTER TABLE table_name MODIFY col_name new_datatype new_constraints;
  ALTER TABLE professors MODIFY id INT NOT NULL;
  select * from professors;
  
  -- TRUNCATE::: (to delete table's data)    TRUNCATE TABLE table_name;
  -- TRUNCATE TABLE student;
  
  -- JOINS:::
  -- join is used to combine rows from two or more tables based on a related column between them
  
  -- Types of Join:::
  -- 1) INNER JOIN ::: returns record that have matching values in both tables
  -- SELECT column FROM tableA INNER JOIN tableB ON tableA.col_name = tableB.col_name; 
  
  CREATE TABLE stu(
  student_id INT PRIMARY KEY,
  name VARCHAR(30)
  );
  
  CREATE TABLE course(
  student_id INT PRIMARY KEY,
  course VARCHAR(30)
  );
  
  INSERT INTO stu(student_id,name) 
  VALUES 
  (101,"Adam"),
  (102,"bob"),
  (103,"Candy");
  
  INSERT INTO course(student_id,course) 
  VALUES
  (101,"english"),
  (105,"math"),
  (103,"science"),
  (107,"computer");
  
  SELECT * FROM stu INNER JOIN course ON stu.student_id = course.student_id;

  -- 2) LEFT JOIN ::: returns all records from the left table and the matched record from the right table
  -- SELECT column FROM tableA LEFT JOIN tableB ON tableA.col_name = tableB.col_name; 
  SELECT * FROM stu LEFT JOIN course ON stu.student_id = course.student_id;
  
  -- 3) RIGHT JOIN ::: returns all records from the right table and the matched record from the left table
  -- SELECT column FROM tableA RIGHT JOIN tableB ON tableA.col_name = tableB.col_name; 
  SELECT * FROM stu RIGHT JOIN course ON stu.student_id = course.student_id;
  
  -- 4) FULL JOIN ::: returns all records when there is a match in either left or right table
  -- SELECT column FROM tableA LEFT JOIN tableB ON tableA.col_name = tableB.col_name UNION SELECT column FROM tableA RIGHT JOIN tableB ON tableA.col_name = tableB.col_name; 
  -- LEFT JOIN UNION RIGHT JOIN
    SELECT * FROM stu LEFT JOIN course ON stu.student_id = course.student_id UNION   SELECT * FROM stu RIGHT JOIN course ON stu.student_id = course.student_id;
  
 -- LEFT EXCLUSIVE JOIN --> only left
   SELECT * FROM stu LEFT JOIN course ON stu.student_id = course.student_id WHERE course.student_id IS NULL;
 -- RIGHT EXCLUSIVE JOIN --> only right
   SELECT * FROM stu RIGHT JOIN course ON stu.student_id = course.student_id WHERE stu.student_id IS NULL;
   
   -- 5) SELF JOIN ::: it is regular join but the table is joined with itself
   -- SELECT column FROM table as a JOIN table as b ON a.col_name = b.col_name;
   SELECT a.name , b.course FROM stu as a JOIN course as b ON a.student_id = b.student_id;
   SELECT * FROM stu as a JOIN course as b ON a.student_id = b.student_id;
 
 
-- UNION::: gives unique record
-- SELECT col FROM tableA UNION SELECT col FROM tableB;
SELECT name FROM stu UNION SELECT course FROM course;

-- UNION ALL::: allows duplicates
-- SELECT col FROM tableA UNION ALL SELECT col FROM tableB;
SELECT name FROM stu UNION ALL SELECT course FROM course;


-- SQL Sub Queries::: SubQuery/InnerQuery/NestedQuery
-- SELECT col FROM table_name WHERE col_name Operator (subquery);
CREATE TABLE students(
rollno INT PRIMARY KEY,
name VARCHAR(30),
marks INT NOT NULL
);

INSERT INTO students(rollno,name,marks)
VALUES
(101,"anil",78),
(102,"bhumika",93),
(103,"chetan",85),
(104,"dhruv",96),
(105,"emanuel",92),
(106,"farah",82);

SELECT * FROM students WHERE marks > (SELECT AVG(marks) FROM students);
SELECT name , rollno FROM students WHERE rollno IN (SELECT rollno FROM students WHERE rollno % 2 = 0);
SELECT MAX(marks) FROM (SELECT * FROM students WHERE rollno > 103) AS temp;


-- MySQL Views::: create virtual table of the required data
-- CREATE VIEW view1 AS SELECT col1,col2 FROM table_name ;
-- SELECT * FROM VIEW;

CREATE VIEW view1 AS SELECT name , marks FROM students;
SELECT * FROM view1;
DROP VIEW view1;
