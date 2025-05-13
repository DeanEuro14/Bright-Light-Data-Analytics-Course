--Convert UTC to SA time (add 2 hours)
SELECT  
  UserID,
  Channel2,
  RecordDate2,
  TO_TIMESTAMP(RecordDate2, 'YYYY/MM/DD HH24:MI') + INTERVAL '2 hour' AS SA_RecordDate
FROM Viewership;

--Join Viewership with UserProfiles
SELECT 
  v.UserID,
  u.Gender,
  u.Age,
  u.Province,
  v.Channel2,
  TO_TIMESTAMP(RecordDate2, 'YYYY/MM/DD HH24:MI') + INTERVAL '2 hour' AS SA_RecordDate
FROM Viewership v
JOIN USER_PROFILES u ON v.UserID = u.UserID;

--Find the Most Watched Days
SELECT 
  DAYNAME(TO_TIMESTAMP(RecordDate2, 'YYYY/MM/DD HH24:MI') + INTERVAL '2 hour') AS DayOfWeek,
  COUNT(*) AS TotalViews
FROM Viewership
GROUP BY DayOfWeek
ORDER BY TotalViews DESC;

--See which Gender watched the Most
SELECT 
  u.Gender,
  COUNT(*) AS TotalViews
FROM Viewership v
JOIN USER_PROFILES u 
  ON v.UserID = u.UserID
GROUP BY u.Gender
ORDER BY TotalViews DESC;

--Find the Most Popular Channel
SELECT 
  Channel2,
  COUNT(*) AS Most_Views
FROM Viewership
GROUP BY Channel2
ORDER BY Most_Views DESC;

--What Content is Watched Each Day
SELECT 
  DAYNAME(TO_TIMESTAMP(RecordDate2, 'YYYY/MM/DD HH24:MI') + INTERVAL '2 hour') AS DayOfWeek,
  Channel2,
  COUNT(*) AS Most_Views
FROM Viewership
GROUP BY DayOfWeek, Channel2
ORDER BY DayOfWeek, Most_Views DESC;

--Viewership by Age Groups
SELECT  v.Channel2,
  CASE 
    WHEN u.Age < 20 THEN 'Under 20'
    WHEN u.Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN u.Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN u.Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN u.Age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END AS Age_Bracket,
FROM Viewership v
JOIN USER_PROFILES u ON v.UserID = u.UserID
GROUP BY Age_Bracket, v.Channel2
ORDER BY Age_Bracket;
