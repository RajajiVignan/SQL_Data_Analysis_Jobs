/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '[Insert File Path]/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '[Insert File Path]/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '[Insert File Path]/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');



-- NOTE: This has been updated from the video to fix issues with encoding
-- Code to copy files for the postgresql of a 
COPY company_dim
FROM 'E:\Projects and Work\Code Folder\Data Analysis\SQL test\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Program Files\PostgreSQL\16\data\Datasets\sql_course\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

The above code is for the postgresql

*/


ALTER TABLE job_postings_fact MODIFY salary_hour_avg DECIMAL(10,2) NULL;
ALTER TABLE job_postings_fact MODIFY salary_year_avg DECIMAL(10,2) NULL;
ALTER TABLE job_postings_fact MODIFY salary_rate TEXT NULL;


-- the following is the code for MySQL csv file load into the table of a database
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/company_dim.csv'
INTO TABLE company_dim
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/skills_dim.csv'
INTO TABLE skills_dim
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/job_postings_fact.csv'
IGNORE INTO TABLE job_postings_fact 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@col1,@col2,@col3,@col4,@col5,@col6,@col7,@col8,@col9,@col10,@col11,@col12,@col13,@col14,@col15,@col16)
SET 
job_id = @col1,
company_id = @col2,
job_title_short = @col3,
job_title = @col4,
job_location = @col5,
job_via = @col6, 
job_schedule_type = @col7, 
job_work_from_home = @col8, 
search_location = @col9, 
job_posted_date = @col10, 
job_no_degree_mention = @col11, 
job_health_insurance = @col12,
job_country = @col13,
salary_rate = NULLIF(@col14, ''),
salary_year_avg = NULLIF(@col15, ''), 
salary_hour_avg = NULLIF(@col16, ''); 
--The last 5 lines are to set the empty cells of the csv file to NULL. IF it is not done mysql can't convert empty strings to NULL directly and throws error.
--here used replace as there were some data previously and was getting a duplicate data error. so replace completely replaces and gives a fresh table. 



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.1/Uploads/skills_job_dim.csv'
INTO TABLE skills_job_dim
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;