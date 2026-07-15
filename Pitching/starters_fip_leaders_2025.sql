/*
Question:
Which starters had the best Fielding Independent Pitching (FIP) in 2025?

Formula:
FIP = ((13*HR)+(3*(BB+HBP))-(2*K))/IP + 3.135

Notes:
- Uses Lahman Pitching table.
- Converts IPouts to innings pitched.
- Requires at least 30 IP (90 IPouts) and 10 games started.
- Combines statistics across multiple teams.
*/


SELECT pt.yearid, p.nameFirst, p.nameLast,  (SUM(pt.IPouts) / 3) || '.' || (SUM(pt.IPouts) % 3) AS IP,
ROUND(
    CAST(
        (
            (13 * SUM(pt.HR))
            + (3 * (SUM(pt.BB) + SUM(pt.HBP)))
            - (2 * SUM(pt.SO))
        ) AS REAL
    ) / (SUM(pt.IPouts) / 3.0)+ 3.135,
    2
) AS FIP
FROM People p JOIN Pitching pt ON p.playerID = pt.playerID 
WHERE pt.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(pt.IPouts) >= 90 AND SUM(pt.IPouts) > 0 AND SUM(pt.GS >=10)
ORDER BY FIP ASC
LIMIT 10;
