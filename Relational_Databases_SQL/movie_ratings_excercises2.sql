/* 
Q1. Find the names of all reviewers who rated Gone with the Wind.
*/
SELECT name
FROM Reviewer r1
WHERE r1.rID in
	(SELECT rID 
	From Movie JOIN Rating using(mID) 
	WHERE title = 'Gone with the Wind');

/* 
Q2. For any rating where the reviewer is the same as the director of the movie, 
return the reviewer name, movie title, and number of stars.
*/
SELECT re.name, m.title, ra.stars 
FROM Movie m 
JOIN Rating ra
	on m.mID = ra.mID
JOIN Reviewer re
	ON ra.rID = re.rID
WHERE name = director;

/*
Q3.
Return all reviewer names and movie names together in a single list, alphabetized. 
(Sorting by the first name of the reviewer and first word in the title is fine; no 
need for special processing on last names or removing "The".)
*/
SELECT * 
FROM (SELECT r.name FROM Reviewer r ORDER BY 1) as o
UNION
SELECT * 
FROM (SELECT m.title FROM Movie m ORDER BY 1) as t


/*
Q4.
Find the titles of all movies not reviewed by Chris Jackson.
*/
SELECT title
FROM Movie m
WHERE m.mID NOT IN
	( SELECT mID 
     FROM (Movie JOIN(Rating) using(mID)) JOIN Reviewer using(rID)
     WHERE name = 'Chris Jackson');

/*
Q5.
For all pairs of reviewers such that both reviewers gave a rating to the 
same movie, return the names of both reviewers. Eliminate duplicates, 
don't pair reviewers with themselves, and include each pair only once. 
For each pair, return the names in the pair in alphabetical order.
*/


/* 
Q6. For each rating that is the lowest (fewest stars) currently in the database, 
return the reviewer name, movie title, and number of stars.
*/
SELECT name, title, stars
FROM (Movie JOIN Rating USING(mID)) JOIN Reviewer USING(rID)
WHERE stars = (SELECT min(stars) FROM Rating)


/* 
Q7. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more 
movies have the same average rating, list them in alphabetical order.
*/
SELECT title, avg(stars) as average_rating
FROM Movie JOIN Rating USING(mID)
GROUP BY title
ORDER BY average_rating DESC, title;

/* 
Q8. Find the names of all reviewers who have contributed three or more ratings. 
*/
SELECT name
FROM Reviewer re
WHERE rID IN ( 
	SELECT ra.rID FROM (
		SELECT r.rID, COUNT(r.rID) as c
		FROM Rating r
		GROUP BY r.rID
		HAVING c >= 3
		) as ra
	);
    
/* 
Q9. Some directors directed more than one movie. For all such directors, 
return the titles of all movies directed by them, along with the director name. 
Sort by director name, then movie title. (As an extra challenge, try writing 
the query both with and without COUNT.) 
*/
SELECT title, director 
FROM Movie m
WHERE m.director in ( 
	SELECT m2.director FROM (
		SELECT director, COUNT(mID) movie_count
		FROM Movie
		GROUP BY director
		HAVING movie_count > 1 
        ) 
	m2) 
ORDER BY director, title;

/* 
Q10. Find the movie(s) with the highest average rating. Return the movie title(s) 
and average rating. 
*/
SELECT title, avg(stars) as avg_rating
FROM Movie JOIN Rating USING(mID)
GROUP BY title
HAVING avg_rating = (
	SELECT avg(stars) as avg_rating
	FROM Movie JOIN Rating USING(mID)
	GROUP BY title
	ORDER BY avg_rating DESC
	LIMIT 1
);

/* 
Q11. Find the movie(s) with the lowest average rating. Return the movie title(s) 
and average rating.
*/
SELECT title, avg(stars) as avg_rating
FROM Movie JOIN Rating USING(mID)
GROUP BY title
HAVING avg_rating = (
	SELECT avg(stars) as avg_rating
	FROM Movie JOIN Rating USING(mID)
	GROUP BY title
	ORDER BY avg_rating
	LIMIT 1
);

/* 
Q12. For each director, return the director's name together with the title(s) of 
the movie(s) they directed that received the highest rating among all of their movies, 
and the value of that rating. Ignore movies whose director is NULL.
*/





    
			
    
    
    