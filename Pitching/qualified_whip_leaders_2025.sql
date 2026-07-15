/*
Question:
Which qualified MLB pitchers had the lowest Walks plus Hits per Inning Pitched (WHIP) during the 2025 season?

Qualification:
Pitchers must have pitched at least 162.0 innings (486 outs), matching the standard MLB qualification of 1 inning pitched per team game.

Formula:
WHIP = (BB + H) / IP

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

SELECT pt.yearid, p.nameFirst, p.nameLast,  (SUM(pt.IPouts) / 3) || '.' || (SUM(pt.IPouts) % 3) AS IP, SUM(pt.H) AS H,  SUM(pt.BB) AS BB,
 ROUND(
    CAST(
        (
            SUM(pt.BB) + SUM(pt.H)
        ) AS REAL
    ) / (SUM(pt.IPouts) / 3.0),
    3
) AS WHIP
FROM People p JOIN Pitching pt ON p.playerID = pt.playerID 
WHERE pt.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(pt.IPouts) >= 486
ORDER BY WHIP ASC
LIMIT 10;