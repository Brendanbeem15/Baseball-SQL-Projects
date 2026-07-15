/*
Question:
Which MLB hitters with at least 200 at-bats had the lowest strikeout percentage (K%) during the 2025 season?

Formula:
K% = (SO / PA) * 100

Where:
PA = AB + BB + HBP + SF + SH

Tables:
People
Batting

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() for decimal calculations
- ROUND()
- HAVING to require a minimum workload
- Combines statistics for players who appeared with multiple teams

*/

SELECT b.yearid, p.nameFirst, p.nameLast, (
    SUM(b.AB)
    + SUM(b.BB)
    + SUM(b.HBP)
    + SUM(b.SF)
    + SUM(b.SH)
) AS PA, SUM(b.SO) AS K, 
ROUND(
    CAST(
	(
	SUM(b.SO) *100
	) AS REAL) / (SUM(b.AB)+ SUM(b.BB)+ SUM(b.HBP)+SUM(b.SF) + SUM(b.SH) ), 1
) AS KPerc
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 200
ORDER BY KPerc ASC 
LIMIT 10;