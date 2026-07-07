/*
Question:
How many Hall of Famers were inducted each year since 2015?

Tables:
HallOfFame

Concepts:
WHERE, COUNT, GROUP BY, ORDER BY
*/

SELECT yearid, COUNT(*) AS hof_since_2015
FROM HallOfFame 
WHERE inducted = 'Y'
  AND yearID >= 2015
  GROUP BY yearID
ORDER BY yearID DESC;
