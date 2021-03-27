/* Subqueries in WHERE clause (nested SELECT) */

/* Example: All student IDS and names who applied to CS as a major */
SELECT sID, sName
FROM Student
WHERE sID in (SELECT sID FROM APPLY WHERE major = 'CS');

/* Can achieve the same goal with a natural join but have to use DISTINCT
because we are no longer looking 'in' a set*/
SELECT DISTINCT s.sID, sName
FROM Student s, Apply a
WHERE s.sID = a.sID AND major = 'CS';

/* GPA of Students that applied to CS */
SELECT GPA
FROM Student
WHERE sID IN (SELECT sID FROM Apply WHERE major = 'CS');

/* Return students who have applied to major in CS but have NOT applied to EE */
SELECT sName,sID
FROM Student
WHERE sID IN (SELECT sID FROM Apply WHERE major = 'CS')
	AND sID NOT IN (SELECT sID FROM Apply WHERE major = 'EE');
    
/* same using ANY */
SELECT sName,sID
FROM Student
WHERE sID = ANY (SELECT sID FROM Apply WHERE major = 'CS')
	AND NOT sID = ANY (SELECT sID FROM Apply WHERE major = 'EE');
    
/* Find all colleges which have another college in the same state */
SELECT cName, state
FROM College c1
WHERE EXISTS (SELECT * FROM College c2
			  WHERE c2.state = c1.state AND c1.cName <> c2.cName);
              
/* Find max enrollment college without using MAX() */
SELECT cName
FROM College c1
WHERE NOT EXISTS (SELECT * FROM College c2
				  WHERE c2.enrollment > c1.enrollment);
/* Using ALL */
SELECT cName
FROM College s1
WHERE enrollment > ALL (SELECT enrollment FROM college s2
						WHERE s2.cName <> s1.cName);
                  
/* find sudent with highest GPA without using MAX() */
SELECT sName, sID, GPA
FROM Student s1
WHERE NOT EXISTS (SELECT * FROM Student s2 
				  WHERE s2.GPA > s1.GPA);
                  
/* or using ALL */
SELECT sName, GPA
FROM Student
WHERE GPA >= ALL (SELECT GPA FROM STUDENT);

/* return all students expect those from the smallest highschool */
SELECT sName, sID, sizeHS
FROM Student
WHERE sizeHS > ANY (SELECT sizeHS FROM Student);

/* using EXISTS instead of ANY */
SELECT sName, sID, sizeHS
FROM Student s1
WHERE EXISTS (SELECT * FROM Student s2
				WHERE s2.sizeHS < s1.sizeHS);