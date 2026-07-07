

SELECT b.yearid, p.nameFirst, p.nameLast, SUM(b.H) AS H, SUM(b."2B") AS Doubles,
SUM(b."3B") AS Triples, SUM(b.HR) AS HomeRuns, SUM(b.AB) AS AB,
ROUND(
    CAST((
    (SUM(b.H) - SUM(b."2B") - SUM(b."3B") - SUM(b.HR))
    + (2 * SUM(b."2B"))
    + (3 * SUM(b."3B"))
    + (4 * SUM(b.HR))
)AS REAL) / SUM(b.AB),
    3
) AS SLG
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 200
ORDER BY SLG DESC 
LIMIT 10;