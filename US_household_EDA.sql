/*

US Household Income 
(Exploratory Data Analysis)

*/

SELECT *
FROM US_project.us_household_income
;

SELECT *
FROM US_project.us_household_income_statistics;
;


-- Finding total area of land and water of each state

SELECT  State_Name,
	SUM(ALand), 
	SUM(AWater)
FROM US_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;


-- Combining 2 tables 
SELECT *
FROM US_project.us_household_income  u
JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;
   

SELECT u.State_Name, 
	County, Type, 
	'Primary', 
	Mean, 
	Median
FROM US_project.us_household_income  u
INNER JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- TOP 5 lowest income states

SELECT  u.State_Name, 
	ROUND(AVG(Mean), 1), 
        ROUND(AVG(Median), 1)
FROM US_project.us_household_income  u
INNER JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 5
;


-- TOP 10 highest income states

SELECT  u.State_Name, 
	ROUND(AVG(Mean), 1) AS avg_salary, 
        ROUND(AVG(Median), 1) AS median_salary
FROM US_project.us_household_income  u
INNER JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;
   

-- Income by Type of locality 

SELECT  Type, 
	COUNT(Type),
	ROUND(AVG(Mean), 1), 
        ROUND(AVG(Median), 1)
FROM US_project.us_household_income  u
INNER JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
	
-- excluding outliers by:
	
HAVING COUNT(Type) > 100
-- end 
ORDER BY 4 DESC
LIMIT 20
;



-- Low income states with County Urban and Community

SELECT * 
FROM US_project.us_household_income
WHERE Type = 'Community'
;


-- Finding cities with the highest household income

SELECT  u.State_Name, City, 
	ROUND(AVG(Mean), 1) AS avg_income,
        ROUND(AVG(Median), 1) AS median_income
FROM US_project.us_household_income  u
RIGHT JOIN US_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name, City
ORDER BY avg_income DESC
LIMIT 10
;
