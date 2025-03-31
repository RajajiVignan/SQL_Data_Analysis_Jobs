SELECT * FROM job_postings_fact LIMIT 5;

DELETE FROM job_postings_fact WHERE job_id = 0;


ALTER TABLE job_postings_fact
MODIFY job_work_from_home TEXT;

ALTER TABLE job_postings_fact
MODIFY job_no_degree_mention TEXT;

ALTER TABLE job_postings_fact
MODIFY job_health_insurance TEXT;






--  FOr the missing data of first row where job_id = 0, added the below values. 
UPDATE job_postings_fact
SET 
company_id= 0,
job_title_short = 'Data Analyst', 
job_title = 'Marketing Data Analyst',  
job_location = 'Anywhere', 
job_via = 'via LinkedIn', 
job_schedule_type = 'Full-time', 
job_work_from_home = 'True',
search_location = 'Serbia',
job_posted_date='2023-09-25 17:46:06',
job_no_degree_mention = 'False',
job_health_insurance = 'False',
job_country = 'Serbia'


WHERE job_id = 0;


-- Changing the date and time column to show only date
SELECT 
    job_title_short as title, 
    job_location as location, 
    DATE(job_posted_date) as date
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_title_short as title, 
    job_location as location, 
    job_posted_date as date
FROM job_postings_fact
LIMIT 10;

-- changing the timezone of a column with date and time.
SELECT 
    job_title_short as title, 
    job_location as location, 
    CONVERT_TZ(job_posted_date, '+05:00', '+00:00') as date
FROM job_postings_fact
LIMIT 10;

SELECT
    COUNT(job_id) AS job_posted_count, 
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY job_posted_count DESC;d

-- creating a new table based on month 
CREATE TABLE jobs_jan AS
    SELECT 
        *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1 and
        EXTRACT(YEAR FROM job_posted_date) = 2023

CREATE TABLE jobs_feb AS
    SELECT 
        *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 2

CREATE TABLE jobs_mar AS
    SELECT 
        *
    FROM 
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 3


DROP TABLE jobs_2023

SELECT * FROM jobs_mar LIMIT 5;


-- Case Expression

SELECT 
        Case 
            WHEN job_location = 'Anywhere' THEN 'Remote'
            ELSE 'Onsite'
        END AS job_location_category,
        COUNT(job_id) as job_number
FROM job_postings_fact;
GROUP BY job_location_category;


SELECT 
    COUNT(job_id) as job_number,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        ELSE 'Onsite'
    END AS job_location_category
FROM job_postings_fact
GROUP BY 
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        ELSE 'Onsite'
    END;




-- Subqueries 

SELECT * 
FROM ( 
        SELECT * 
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) =1
) AS jan_jobs;


SELECT * 
FROM ( 
        SELECT job_id, job_title_short, job_title, job_location, job_via, job_schedule_type, 
               job_work_from_home, search_location, job_posted_date, job_no_degree_mention, 
               job_health_insurance, job_country
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS jan_jobs;


--CTEs for company job postings 

WITH company_job_count AS (
    SELECT 
        company_id, 
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT name, job_count FROM company_dim
Left JOIN company_job_count
ON company_dim.company_id = company_job_count.company_id
ORDER BY job_count DESC


--UNIONS 

SELECT job_title_short, 
        company_id, 
        job_location 
        
FROM jobs_jan 

UNION
SELECT job_title_short, 
        company_id, 
        job_location
FROM jobs_feb
UNION
SELECT job_title_short, 
        company_id, 
        job_location
FROM jobs_mar;
