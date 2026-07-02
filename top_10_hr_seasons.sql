/*
Lahman Query 1
Top 10 single-season HR totals
Tables used: Batting
Main idea: ORDER BY DESC + LIMIT
*/
SELECT playerID,  yearID, teamID, HR FROM Batting ORDER BY HR DESC LIMIT 10;