/*
Question: Which MLB players had the highest BABIP in 2025? 
Notes:
 - Combines statistics across multiple teams for traded players.
 - Requires at least 30 total at-bats.
 - Excludes players with zero balls in play. 
 
 Formula: BABIP = (H - HR) / (AB - SO - HR + SF) 
 */

SELECT p.nameFirst, p.nameLast, b.yearid, ROUND( CAST(SUM(b.H) - SUM(b.HR) AS REAL) / (SUM(b.AB)- SUM(b.SO)-SUM(b.HR)+SUM(b.SF) ),3 )  AS BABIP
FROM People p JOIN Batting b ON p.playerID = b.playerID 
WHERE b.yearid = 2025 
GROUP BY p.playerID, p.nameFirst, p.nameLast
HAVING SUM(b.AB) >= 30 AND (SUM(b.AB) - SUM(b.SO) - SUM(b.HR) + SUM(b.SF)) > 0
ORDER BY BABIP DESC 
LIMIT 100;
