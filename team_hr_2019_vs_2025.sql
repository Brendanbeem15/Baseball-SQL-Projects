/*
Year HR comparisons 
Tables used: Batting
Main ideas:
Separate HR by a team by a certain year
Compare years using OR
*/
SELECT teamID, yearID, SUM(HR)  AS team_HR
FROM Batting
WHERE yearID = 2025 OR yearID = 2019
GROUP BY teamID, yearID
ORDER BY team_HR DESC;