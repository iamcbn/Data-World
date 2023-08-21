-- SECTION ONE (CLEANING/MODIFYING): I modified the table by replacing abbreviated data

-- I WAS INSPECTING THE COLUMNS CONTAINED IN THE TABLE
SELECT * FROM DSSalary.dbo.Salaries

-- I NOTICED THAT SOME OF THE COLUMNS CONTAINED ABBREVIATED DATA. 
SELECT DISTINCT experience_level, 
	CASE experience_level
		WHEN 'MI' THEN 'Mid-level'
		WHEN 'SE' THEN 'Senior-level'
		WHEN 'EX' THEN 'Executive-level'
		ELSE 'Entry-level'
	END
FROM Salaries

-- I replaced the abbreviated data in the column 'experience_level' with the full text
UPDATE Salaries
SET experience_level =
	CASE experience_level
		WHEN 'MI' THEN 'Mid-level'
		WHEN 'SE' THEN 'Senior-level'
		WHEN 'EX' THEN 'Executive-level'
		ELSE 'Entry-level'
	END

-- It is time to replace abbreviated data in the column employment_type

SELECT DISTINCT employment_type,
	CASE employment_type
		WHEN 'PT' THEN 'Part-time'
		WHEN 'FT' THEN 'Full-time'
		WHEN 'CT' THEN 'Contract'
		ELSE 'Freelance'
	END AS EmploymentType
FROM Salaries

UPDATE Salaries
	SET employment_type = 
		CASE employment_type
		WHEN 'PT' THEN 'Part-time'
		WHEN 'FT' THEN 'Full-time'
		WHEN 'CT' THEN 'Contract'
		ELSE 'Freelance'
	END

SELECT DISTINCT employment_type FROM Salaries

-- Let us change the abbreviated data in the column company_size

SELECT DISTINCT company_size,
	CASE company_size
		WHEN 'L' THEN 'Large'
		WHEN 'S' THEN 'Small'
		ELSE 'Medium'
	END
FROM Salaries

UPDATE Salaries
	SET company_size =
		CASE company_size
		WHEN 'L' THEN 'Large'
		WHEN 'S' THEN 'Small'
		ELSE 'Medium'
	END


-- Here, I added a new column that explains the column remote_ratio

ALTER TABLE Salaries
ADD location_type VARCHAR (50) NULL
	
UPDATE Salaries
	SET location_type = 
		CASE remote_ratio
			WHEN 100 THEN 'Remote'
			WHEN 50 THEN 'Hybrid'
			ELSE 'On-site'
		END 

SELECT DISTINCT location_type FROM Salaries


-- SECTION TWO (EDA): The goal of this section is to explore the table to understand it as well as provide insights.

-- Firstly, let us determine what field in the data world pay the most on average.
-- Before we determine their pay, let us do a general census

SELECT COUNT(*) AS num_professionals
FROM Salaries

-- Let us determine yearly data professionals population growth
SELECT	work_year, 
		COUNT (*) AS num_professionals
FROM DSSalary..Salaries 
GROUP BY work_year
ORDER BY 1  /*There have been steady growth in the various data field.*/


--Let us know how populated each fields are
SELECT	job_title, 
		COUNT(*) AS num_professionals
FROM DSSalary.dbo.Salaries
GROUP BY job_title
ORDER BY 2 DESC

-- Let us drill down to determine the number of professional over time

SELECT	work_year,
		job_title, 
		COUNT(*) AS num_professionals
FROM DSSalary.dbo.Salaries
GROUP BY work_year, job_title
ORDER BY 1, 3 DESC

-- Time for the big guns, their salaries on average, atandard deviation as well as minimum salary and maximum salary
SELECT	job_title,
		AVG(salary_in_usd) AS avg_salaries,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salaries, 
		MAX(salary_in_usd) AS max_salaries
FROM DSSalary.dbo.Salaries
GROUP BY job_title
ORDER BY 2 DESC

-- Let us concentrate on Data Sciencist (DS), Data Enginner (DE) and Data Analyst (DA)
SELECT	job_title,
		AVG(salary_in_usd) AS avg_salaries,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salaries, 
		MAX(salary_in_usd) AS max_salaries
FROM DSSalary.dbo.Salaries
GROUP BY job_title
HAVING job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst') 
ORDER BY 2 DESC

--Drilling down to check their yearly trend concentrating only on Data Sciencist, Data Enginner and Data Analyst
SELECT	work_year,
		job_title,
		AVG(salary_in_usd) AS avg_salaries,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salaries, 
		MAX(salary_in_usd) AS max_salaries
FROM DSSalary.dbo.Salaries
GROUP BY work_year, job_title
HAVING job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst') 
ORDER BY 1, 3 DESC

-- Let us determine where majority of the data professionals resides

SELECT	cou.CountryName AS professionals_residence,
		COUNT(*) AS num_professionals, 
		AVG(sal.salary_in_usd) AS avg_salary
FROM DSSalary.dbo.CountryCodes cou
JOIN DSSalary.dbo.Salaries sal 
	ON cou.Code = sal.employee_residence
GROUP BY cou.CountryName
ORDER BY 2 DESC

-- Does company size affect their salaries?

SELECT	company_size,
		AVG(salary_in_usd) AS avg_salaries,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salaries,
		MAX(salary_in_usd) AS max_salaries
FROM Salaries
GROUP BY company_size
ORDER BY 2 DESC   -- Company size does not really matter since Medium Companies paid their employee on average more than Large companies.


-- Let's explore the average, standard deviation minimum and maximum salaries of DA, DE and DS  based on their experience level 
SELECT	job_title,
		experience_level,
		AVG(salary_in_usd) AS avg_salary,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salary,
		MAX(salary_in_usd) AS max_salary
FROM Salaries
GROUP BY experience_level, job_title
HAVING job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst') 
ORDER BY 1, 3

-- Let's explore the yearly trend average, standard deviation, minimum and maximum salaries of DA, DE and DS  based on their experience level 
SELECT	work_year,
		job_title, 
		experience_level, 
		AVG(salary_in_usd) AS avg_salary,
		STDEV(salary_in_usd) AS sd_salary,
		MIN(salary_in_usd) AS min_salary,
		MAX(salary_in_usd) AS max_salary
FROM DSSalary..Salaries
GROUP BY experience_level, job_title, work_year
HAVING job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst') 
ORDER BY 1 DESC, 2, 4


-- Let us explore the mean salary, standard deviation and number of professionals based on their employment types.
SELECT	employment_type,
		AVG(salary_in_usd) AS avg_salary,
		STDEV(salary_in_usd) AS sd_salary,
		COUNT(*) AS num_professionals
FROM Salaries
GROUP BY employment_type
ORDER BY 2 DESC


-- On average, how much will you earn in 2023 if you work for a US based company?
SELECT	sal.job_title,
		sal.experience_level,
		AVG(sal.salary_in_usd) AS avg_salary,
		con.CountryName AS company_location
FROM CountryCodes con
JOIN Salaries sal
ON con.Code = sal.company_location
GROUP BY sal.company_location, con.CountryName, experience_level, job_title, work_year
HAVING work_year = 2023
	AND company_location = 'US' 
	AND job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst')
ORDER BY 1, 3

-- In the world of data, working remotely is now a norm. Let us determine how many professionals who work remotely
SELECT	location_type, 
		COUNT(*) AS num_professionals
FROM Salaries
GROUP BY location_type
ORDER BY 2 DESC  --Apparently there are more data professionals who work On-site 


-- Let us determine the modal job model for DS, DE and DA
SELECT	job_title, 
		(SELECT TOP 1 location_type
			FROM (
				SELECT	location_type,
						ROW_NUMBER () OVER (ORDER BY COUNT(*) DESC) AS row_number
				FROM DSSalary..Salaries
				WHERE job_title = t.job_title
				GROUP BY location_type
			) AS ranked
			WHERE row_number = 1) AS mode_job_model,
		AVG(remote_ratio) AS avg_remote_ratio
FROM DSSalary..Salaries AS t
GROUP BY job_title 
HAVING job_title IN ('Data Scientist', 'Data Engineer', 'Data Analyst')
ORDER BY 2 DESC
