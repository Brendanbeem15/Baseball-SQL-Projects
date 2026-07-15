/*
Question:
Which MLB hitters with at least 200 at-bats had the highest walk percentage (BB%) during the 2025 season?

Formula:
BB% = (BB / PA) * 100

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
) AS PA, SUM(b.BB) AS BB, 
ROUND(
    CAST(
	(
	SUM(b.BB) *100
	) AS REAL) / (SUM(b.AB)+ SUM(b.BB)+ SUM(b.HBP)+SUM(b.SF) + SUM(b.SH) ), 1
) AS BBPerc
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 200
ORDER BY BBPerc DESC 
LIMIT 10;