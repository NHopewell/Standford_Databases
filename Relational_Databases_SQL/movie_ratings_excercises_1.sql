/* Q1. Find the titles of all movies directed by Steven Spielberg. */

SELECT title
FROM Movie
WHERE director = 'Steven Spielberg';


/* Q2. Find the titles of all movies directed by Steven Spielberg. */
SELECT DISTINCT(year)
FROM Movie JOIN Rating USING(mID)
WHERE stars IN (4, 5)
ORDER BY year;

/* Q3. Find the titles of all movies that have no ratings. */
SELECT title
FROM Movie
WHERE mID NOT IN (SELECT mID FROM Rating);

/* Q4. Some reviewers didn't provide a date with their rating. Find the names of 
	all reviewers who have ratings with a NULL value for the date */

SELECT DISTINCT(name)
FROM Reviewer r JOIN Rating
WHERE r.rID IN (SELECT rID FROM RATING WHERE ratingDate IS NULL);

/* Q5. Write a query to return the ratings data in a more readable format: 
	reviewer name, movie title, stars, and ratingDate. Also, sort the data, 
    first by reviewer name, then by movie title, and lastly by number of stars. */
    
SELECT Re.name, M.title, Ra.stars, Ra.ratingDate
FROM (Movie M JOIN Rating Ra USING(mID)) JOIN Reviewer Re USING(rID)
ORDER BY 1, 2, 3;
   
   
/* Q6

For all cases where the same reviewer rated the same movie twice and gave it a 
higher rating the second time, return the reviewer's name and the title of the movie.

*/


/* Q7
For each movie that has at least one rating, find the highest number of stars that movie received. 
Return the movie title and number of stars. Sort by movie title.

*/
SELECT title, max(stars)
FROM Movie JOIN Rating using(mID)
WHERE mID IN (
	SELECT mID
	FROM Rating
    )
GROUP BY title
ORDER BY title;

/* Q8
For each movie, return the title and the 'rating spread', that is, the difference between 
highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, 
then by movie title.
*/

SELECT r2.title, (r2.max_rating - r2.min_rating) as rating_spread
FROM (
	SELECT title, mID, max(stars) as max_rating, min(stars) as min_rating
	FROM Movie JOIN Rating using(mID)
	GROUP BY mID, title) 
AS r2
ORDER BY rating_spread desc, title;


/* Q9

Find the difference between the average rating of movies released before 1980 and the average 
rating of movies released after 1980. (Make sure to calculate the average rating for each movie, 
then the average of those averages for movies before 1980 and movies after. Don't just calculate 
the overall average rating before and after 1980.)

*/

SELECT abs(
    ( 
        SELECT AVG(r2.1981_and_older_avg)
        FROM
            (SELECT year, mID, avg(stars) as 1981_and_older_avg
            FROM Rating
            JOIN Movie USING(mID)
            GROUP BY mID, year
            HAVING year > 1980) as r2 
            
    ) 
        -
    ( 
        SELECT AVG(r3.1979_and_younger_avg)
        FROM
            (SELECT year, mID, avg(stars) as 1979_and_younger_avg
            FROM Rating
            JOIN Movie USING(mID)
            GROUP BY mID, year
            HAVING year < 1980) as r3
    )
) as difference_in_ratings;