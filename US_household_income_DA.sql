/* 

US Household Income 2022
(Data Cleaning)

*/


SELECT *
FROM US_project.us_household_income;

SELECT *
FROM US_project.us_household_income_statistics;
;

-- 
SELECT COUNT(id)
FROM US_project.us_household_income;
;

SELECT COUNT(id)
FROM US_project.us_household_income_statistics;
;



-- Identifying duplicates and deleting them

SELECT id, COUNT(id)
FROM US_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;


SELECT *
FROM (
SELECT row_id, id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_household_income) duplicates
WHERE row_num > 1
;

DELETE FROM us_household_income 
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id, id,
				ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_household_income) duplicates
	WHERE row_num > 1)
;


-- Checking consistency of column 'State_Name' values 

SELECT State_Name
FROM US_project.us_household_income
ORDER BY State_Name
;

-- Corrercting misspeled cell values

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

-- Correcting inconsistent values
SELECT *
FROM US_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;


UPDATE US_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


SELECT Type, COUNT(Type)
FROM US_project.us_household_income
GROUP BY Type
ORDER BY 1
;


UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;


-- Finding 'Null' or '0' values 

SELECT DISTINCT AWater
FROM US_project.us_household_income
WHERE AWater = 0 OR AWater = ' ' OR AWater IS NULL
;


-- Some irregular values where some counties have no land area
SELECT County, ALand, AWater
FROM US_project.us_household_income
WHERE (ALand = 0 OR ALand = ' ' OR ALand IS NULL)
;
