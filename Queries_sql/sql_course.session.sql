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
ORDER BY job_posted_count DESC;