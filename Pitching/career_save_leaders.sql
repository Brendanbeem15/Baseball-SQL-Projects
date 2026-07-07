/*
Question:
Who are the career saves leaders in MLB history?

Tables:
Pitching
People

Concepts:
JOIN
SUM
GROUP BY
ORDER BY
LIMIT
*/
SELECT p.nameFirst, p.nameLast, SUM(pt.SV) AS Career_SV
FROM Pitching pt  JOIN People p ON pt.playerID = p.playerID
GROUP BY pt.playerID, p.nameFirst, p.nameLast
ORDER BY Career_SV DESC 
LIMIT 10;
