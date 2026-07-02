



SELECT P.nameFirst, P.nameLast, P.birthYear, SUM(pt.SV) AS Career_SV
FROM People P JOIN HallOfFame H  ON P.playerID = H.playerID JOIN Pitching pt ON P.playerID = pt.playerID
WHERE H.inducted = 'Y' AND deathYear IS NULL 
GROUP BY P.playerID, P.nameFirst, P.nameLast, P.birthYear
HAVING SUM(pt.GS) < 500
ORDER BY Career_SV DESC
LIMIT 8;