SELECT COUNT(*) AS job_postings_count
FROM job_postings_fact;

/*
PROBLEM STATEMENT:
Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill

*/

WITH remote_jobs AS (
SELECT
    job_id
FROM job_postings_fact
WHERE job_location = 'Anywhere' AND job_title_short = "Data Analyst"
)


SELECT 
    s1.skill_id as skill_id,
    s1.skills as skill_name,
    COUNT(*) as count_of_postings
FROM skills_dim as S1
INNER JOIN skills_job_dim AS s2 ON s2.skill_id = s1.skill_id
INNER JOIN remote_jobs ON s2.job_id = remote_jobs.job_id 
GROUP BY s1.skill_id
ORDER BY count_of_postings DESC
LIMIT 5;




/*
Problem statement2: 
Find job postings from the first quarter that have a salary greater than $70k
- Combine job postings tables from the first quarter of 2023 (jan-mar)
- Gets job postings with an average yearly salary greater than $70k

*/

WITH job_temp AS (
    SELECT * FROM jobs_jan
    UNION ALL
    SELECT * FROM jobs_feb
    UNION ALL
    SELECT * FROM jobs_mar
)

SELECT 
    job_id,
    job_title_short,
    job_location,
    job_posted_date,
    salary_year_avg
FROM job_temp
WHERE salary_year_avg > 70000 AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;