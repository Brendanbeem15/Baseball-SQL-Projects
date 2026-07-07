/* 
Question:
Who are the oldest living Hall of Famers?

Tables:
People
HallOfFame

Concepts:
JOIN
WHERE
ORDER BY
LIMIT
*/

SELECT P.nameFirst, P.nameLast, P.birthYear
FROM People P JOIN HallOfFame H  ON P.playerID = H.playerID 
WHERE H.inducted = 'Y' AND deathYear IS NULL AND H.votedBy = 'BBWAA'
ORDER BY P.birthYear ASC
LIMIT 10;
