/*
Career home run leaders
Tables used: Batting, People
Main idea:
- join Batting to People by playerID
- group all batting rows by player
- sum HR across career
*/
SELECT p.nameFirst, p.nameLast, SUM(b.HR) AS career_HR
FROM Batting b
JOIN People p
    ON b.playerID = p.playerID
GROUP BY b.playerID, p.nameFirst, p.nameLast
ORDER BY career_HR DESC
LIMIT 30;
