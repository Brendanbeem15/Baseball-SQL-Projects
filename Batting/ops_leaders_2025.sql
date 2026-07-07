/*

Question:
Who had the highest On-Base Plus Slugging (OPS) during the 2025 MLB season?

Formula:
OPS = OBP + SLG

OBP = (H + BB + HBP) / (AB + BB + HBP + SF)

SLG = Total Bases / AB

Total Bases:
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
- Derived statistics from raw batting data
- HAVING to require a minimum number of at-bats
- Combines statistics for players who appeared with multiple teams

*/

SELECT b.yearid, p.nameFirst, p.nameLast, SUM(b.H) AS H, SUM(b."2B") AS Doubles,
SUM(b."3B") AS Triples, SUM(b.HR) AS HomeRuns,  SUM(b.BB) AS BB, SUM(b.HBP) AS HBP, SUM(b.AB) AS AB,
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
ORDER BY OPS DESC 
LIMIT 10;