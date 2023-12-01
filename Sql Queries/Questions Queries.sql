-- SOLVING QUESTIONS --

-- 1.How many job titles are we looking at? What are they?

SELECT COUNT(DISTINCT(Job_Title)) AS Total_Job_Titles
FROM Cleaned_Salary ;

SELECT Job_Title , COUNT(Job_Title) As Total_Jobs
FROM Cleaned_Salary
GROUP BY Job_Title
ORDER BY Total_Jobs DESC ;

-- 2.Top 10 highest paid salaries vs the average pay of the job .

SELECT TOP (10)Job_title , Salary_in_USD , Average_Salary 
FROM
	(SELECT Job_Title ,
		   Salary_in_USD ,
		   AVG(Salary_in_USD) OVER (PARTITION BY Job_Title) AS Average_Salary ,
		   ROW_NUMBER() OVER (PARTITION BY Job_Title ORDER BY Salary_in_USD DESC) As R
	FROM Cleaned_Salary ) As C
WHERE R = 1
ORDER BY Salary_in_USD DESC ;

-- 3. Top 5 most popular jobs and their average pay

SELECT TOP(10) Job_Title ,
	   COUNT(Job_Title) As Total_Jobs ,
	   AVG(Salary_in_USD) As Average_Salary
FROM Cleaned_Salary
GROUP BY Job_Title 
ORDER BY Total_Jobs DESC;

-- Importing Country_Code Table in the Database

-- 4. What is the average pay for each country? 

SELECT name  As Country_Name,
	   AVG(Salary_in_USD) As Average_Salary
FROM Cleaned_Salary As CS
JOIN Country_Code As CC On CS.Company_location = CC.alpha_2
GROUP BY name
ORDER BY Average_Salary DESC;

-- 5. Do countries pay alot more than their country’s average? which ones?

WITH MyCte As(
			 SELECT CC.name As Country_Name ,
			 	   CS.Job_Title ,
				   CS.Experience ,
			 	   CS.Salary_in_USD ,
			 	   AVG(Salary_in_USD) OVER (PARTITION BY Company_location) As Average_Pay
			 FROM Cleaned_Salary As CS
			 JOIN Country_Code AS CC ON CC.alpha_2 = CS.Company_location )

SELECT * ,
	   COUNT(Country_Name) OVER (PARTITION BY Country_Name) As jobs_Greater_than_Average_Pay
FROM MyCte
WHERE Salary_in_USD > Average_Pay
ORDER BY jobs_Greater_than_Average_Pay DESC ;


-- 6. What is the average pay as per experience ?

SELECT Experience , AVG(Salary_in_USD) AS Average_Salary_in_USD
FROM Cleaned_Salary
GROUP BY Experience ;

-- 7. Which countries pays the most in Entry Level Jobs ?

SELECT TOP (10) CC.name As Country_Name ,		
	   AVG(Salary_in_USD) As Average_Salary_For_Entry_Level_Jobs
FROM Cleaned_Salary As CS
JOIN Country_Code As CC ON CC.alpha_2 = CS.Company_location
WHERE Experience = 'Entry Level'
GROUP BY CC.name
ORDER BY Average_Salary_For_Entry_Level_Jobs DESC ;

-- 8. Average entry-level pay through the Years ?

SELECT Work_Year , AVG(Salary_in_USD) as Average_Salary
FROM Cleaned_Salary
WHERE Experience = 'Entry Level'
GROUP BY Work_Year

-- 9. Entry Level Jobs Through Years ?

SELECT Work_Year , COUNT(*) As Jobs
FROM Cleaned_Salary
WHERE Experience = 'Entry Level'
GROUP BY Work_Year

-- 10. Which countries pay fully remote entry-level jobs ?

SELECT CC.name As Country_Name , COUNT(*) as Jobs
FROM Cleaned_Salary AS CS
JOIN Country_Code AS CC ON CC.alpha_2 = CS.Company_location
WHERE Experience = 'Entry Level' AND Mobility LIKE 'Full%'
GROUP BY CC.name
ORDER BY Jobs DESC ;
