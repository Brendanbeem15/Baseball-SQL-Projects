


SELECT P.nameFirst, P.nameLast, P.birthYear, SUM(B.HR) AS TotalHR
FROM People P JOIN HallOfFame H  ON P.playerID = H.playerID JOIN Batting B ON P.playerID = B.playerID
WHERE H.inducted = 'Y' AND deathYear IS NULL
GROUP BY P.playerID, P.nameFirst, P.nameLast, P.birthYear
ORDER BY TotalHR DESC
LIMIT 10;