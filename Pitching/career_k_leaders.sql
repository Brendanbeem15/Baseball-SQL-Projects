/*
Career strikeout leaders
Tables used: Pitching, People
Main idea:
- join Pitching to People by playerID
- group all pitching rows by player
- sum K across career
*/
SELECT p.nameFirst, p.nameLast, SUM(pt.SO) AS career_SO
FROM Pitching pt
JOIN People p
    ON pt.playerID = p.playerID
GROUP BY pt.playerID, p.nameFirst, p.nameLast
ORDER BY career_SO DESC
LIMIT 10;
