/*

Question:
Who had the highest Slugging Percentage (SLG) among MLB hitters during the 2025 season who received 200 AB or more?

Formula:
SLG = Total Bases / AB

Where:
Total Bases =
(1B) + (2 × 2B) + (3 × 3B) + (4 × HR)

1B = H − 2B − 3B − HR

Tables:
People
Batting

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() for decimal calculations
- ROUND()
- Derived statistics (Singles and Total Bases)
- HAVING to require a minimum number of at-bats
- Combines statistics for players who appeared with multiple teams

*/

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
