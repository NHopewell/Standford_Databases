/* 
Select all students with the same GPA but do not include
same student twice in one row.
*/
SELECT s1.sID, s1.sName, s1.GPA, s2.sID, s2.sName, s2.GPA
FROM student s1, student s2
WHERE s1.GPA = s2.GPA and s1.sID < s2.sID;

/*
Set operators - Union

Union is used to combine ouput from 2 select statements
- each select statement must have the same number of cols
- cols need to be similar types
- union eliminates duplicates by default
- might come out sorted, sqlite for instance sorts and then 
 compares for duplicates
 
 Example: get all student names from Student and Apply tables
*/
SELECT sName as name FROM Student
UNION
SELECT cName as name from Apply;

/*
Union all

- same as union but does not remove duplicates
*/
SELECT sName as name FROM Student
UNION ALL
SELECT cName as name from Apply;

/*
INTERSECT 

The SQL INTERSECT clause/operator is used to combine two SELECT statements, 
but returns rows only from the first SELECT statement that are identical 
to a row in the second SELECT statement. This means INTERSECT returns only 
common rows returned by the two SELECT statements.

Example: find all students who have applied to CS and EE as a major.

NOTE: MYSQL does not support INTERSECT, so the below code does not work, 
use IN to emulate. or a natural self join (example 2)
*/
SELECT sID from Apply WHERE major = 'CS'
INTERSECT
SELECT sID from Apply WHERE majot = 'EE';

SELECT DISTINCT sID 
FROM Apply 
WHERE major = 'CS' AND sID IN (SELECT sID FROM Apply WHERE major = 'EE');

SELECT DISTINCT a1.sID
FROM Apply a1, Apply a2
WHERE a1.sID = a2.sID AND a1.major = 'CS' AND a2.major = 'EE';


/* 
EXCEPT / DIFFERENCE / MINUS

Get rows from one select which are not present in another. 
Can emulate with NOT IN
*/
SELECT DISTINCT sID 
FROM Apply 
WHERE major = 'CS' AND sID NOT IN (SELECT sID from Apply WHERE major = 'EE');