/*
Question:
Which MLB pitchers with at least 30 innings pitched allowed the fewest Hits per 9 during the 2025 season?

Formula:
H9 = (H*9) / IP

Where:
IP = IPouts / 3

Tables:
People
Pitching

Concepts:
- JOIN
- GROUP BY
- SUM()
- CAST() for decimal calculations
- ROUND()
- HAVING to require a minimum workload
- Combines statistics for pitchers who appeared with multiple teams

*/

SELECT pt.yearid, p.nameFirst, p.nameLast,   (SUM(pt.IPouts) / 3) || '.' || (SUM(pt.IPouts) % 3) AS IP, SUM(pt.H) AS H,
 ROUND(
    CAST(
        (
            SUM(pt.H)*9
        ) AS REAL
    ) / (SUM(pt.IPouts) / 3.0),
    1
) AS H9
FROM People p JOIN Pitching pt ON p.playerID = pt.playerID 
WHERE pt.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(pt.IPouts) >= 90 
ORDER BY H9 ASC
LIMIT 10;