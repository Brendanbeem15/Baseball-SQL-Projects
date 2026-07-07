/*
Question:
Who had the highest batting average (BA) during the 2025 MLB season?

Formula:
BA = H / AB

Tables:
People
Batting

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() to perform decimal division
- ROUND()
- HAVING to require a minimum number of at-bats
- Combines statistics for players who appeared with multiple teams
*/

SELECT b.yearid, p.nameFirst, p.nameLast, SUM(b.H) AS H, SUM(b.AB) AS AB,
ROUND(
    CAST(SUM(b.H) AS REAL) / SUM(b.AB),
    3
) AS BA
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 30
ORDER BY BA DESC 
LIMIT 10;