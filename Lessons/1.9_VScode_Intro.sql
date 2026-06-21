SELECT 42 as answer;



SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';


SELECT
    jpf.company_id AS company_id,
    jpf.job_title_short AS job_title,
    jpf.job_location,
    name
FROM 
    company_dim AS cd
INNER JOIN job_postings_fact AS jpf
    ON jpf.company_id = cd.company_id
WHERE job_location = 'Kenya'
    AND job_title_short IN ('Data Engineer', 'Data Analyst')
LIMIT 20;


SELECT
    *
FROM 
    skills_dim;

SELECT
    COUNT(*)
FROM 
    skills_dim;
