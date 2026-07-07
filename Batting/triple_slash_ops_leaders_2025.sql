/*

Question:
What were the Triple Slash statistics (AVG / OBP / SLG) and OPS for MLB hitters during the 2025 season that received 200 AB or more?

Formula:
AVG = H / AB

OBP = (H + BB + HBP) / (AB + BB + HBP + SF)

SLG = Total Bases / AB

OPS = OBP + SLG

Tables:
People
Batting

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() for decimal calculations
- ROUND()
- Multiple derived statistics in a single query
- HAVING to require a minimum number of at-bats
- Combines statistics for players who appeared with multiple teams

*/

SELECT b.yearid, p.nameFirst, p.nameLast, SUM(b.AB) AS AB, SUM(b.H) AS H, 
ROUND(
    CAST(SUM(b.H) AS REAL) / SUM(b.AB),
    3
) AS BA, 
ROUND(
    CAST(SUM(b.H) + SUM(b.BB) + SUM(b.HBP) AS REAL) / (SUM(b.AB)+ SUM(b.BB)+ SUM(b.HBP)+SUM(b.SF) ),3 
) AS OBP,
ROUND(
    CAST((
    (SUM(b.H) - SUM(b."2B") - SUM(b."3B") - SUM(b.HR))
    + (2 * SUM(b."2B"))
    + (3 * SUM(b."3B"))
    + (4 * SUM(b.HR))
)AS REAL) / SUM(b.AB),
    3
) AS SLG,
ROUND(
    (
        CAST(SUM(b.H) + SUM(b.BB) + SUM(b.HBP) AS REAL)
        /
        (SUM(b.AB)+ SUM(b.BB)+ SUM(b.HBP)+SUM(b.SF))
    )
    +
    (
        CAST(
            (
                (SUM(b.H) - SUM(b."2B") - SUM(b."3B") - SUM(b.HR))
                + (2 * SUM(b."2B"))
                + (3 * SUM(b."3B"))
                + (4 * SUM(b.HR))
            ) AS REAL
        )
        /
        SUM(b.AB)
    ),
    3
) AS OPS
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 200
ORDER BY BA DESC 
LIMIT 10;