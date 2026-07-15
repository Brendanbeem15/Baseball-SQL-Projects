/*
Question:
Which qualified MLB pitchers had the lowest Walks plus Hits per Inning Pitched (WHIP) during the 2025 season?

Qualification:
Pitchers must have pitched at least 162.0 innings (486 outs), matching the standard MLB qualification of 1 inning pitched per team game.

Formula:
BB9 = (BB*9) / IP

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

SELECT pt.yearid, p.nameFirst, p.nameLast,   (SUM(pt.IPouts) / 3) || '.' || (SUM(pt.IPouts) % 3) AS IP, SUM(pt.BB) AS BB,
 ROUND(
    CAST(
        (
            SUM(pt.BB)*9
        ) AS REAL
    ) / (SUM(pt.IPouts) / 3.0),
    1
) AS BB9
FROM People p JOIN Pitching pt ON p.playerID = pt.playerID 
WHERE pt.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(pt.IPouts) >= 486 
ORDER BY BB9 ASC
LIMIT 10;