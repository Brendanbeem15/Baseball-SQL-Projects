/*
Question:
Who had the highest On-Base Percentage (OBP) during the 2025 MLB season?

Formula:
OBP = (H + BB + HBP) / (AB + BB + HBP + SF)

Tables:
People
Batting

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() for decimal calculations
- ROUND()
- HAVING to require a minimum number of at-bats
- Combines statistics for players who appeared with multiple teams

*/

SELECT b.yearid, p.nameFirst, p.nameLast, SUM(b.H) AS H, SUM(b.AB) AS AB, SUM(b.BB) AS BB, SUM(b.HBP) AS HBP,
ROUND(
    CAST(SUM(b.H) + SUM(b.BB) + SUM(b.HBP) AS REAL) / (SUM(b.AB)+ SUM(b.BB)+ SUM(b.HBP)+SUM(b.SF) ),3 
) AS OBP
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 200
ORDER BY OBP DESC 
LIMIT 10;