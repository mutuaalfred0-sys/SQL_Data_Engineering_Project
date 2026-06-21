SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';

/*
Find the top 10 companies for posting jobs
They must have >3000 postings
Limit this to only US jobs
*/


EXPLAIN ANALYSE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY
    posting_count DESC
LIMIT 10;


/*
Find the top 5 job categories for posting remote work
They must have more than 1000 posting
Limit this to where job location is remote
*/

SELECT 
    jpf.job_title_short AS job_category,
    COUNT(jpf.job_location) AS posting_remote
FROM job_postings_fact AS jpf
WHERE jpf.job_work_from_home = TRUE
GROUP BY
    jpf.job_title_short
HAVING COUNT(jpf.job_location) > 1000
LIMIT 5;


/*Find the top 10 companies offering high starting salary
They must have an average minimum salary greater than 120000
Limit this to companies with greater than 100 total postings
*/

SELECT
    cd.name AS company_name,
    ROUND(AVG(jpf.salary_year_avg), 0) AS average_salary,
    COUNT(jpf.job_id) AS posting_count
FROM 
    job_postings_fact AS jpf
INNER JOIN company_dim as cd
    ON jpf.company_id = cd.company_id
GROUP BY cd.name
HAVING AVG(jpf.salary_year_avg) > 120_000
    AND COUNT(jpf.job_id) > 100
ORDER BY average_salary DESC
LIMIT 10;

/*Find the top 10 cities for active job listings
they must have greater than 2000 postings
limit this to only US jobs outsie of California
*/

SELECT
    jpf.job_location AS city_location,
    COUNT(jpf.job_id) AS job_listing
FROM 
    job_postings_fact AS jpf
WHERE jpf.job_country = 'United States' AND jpf.job_location NOT LIKE '%, CA'
GROUP BY jpf.job_location
HAVING COUNT(jpf.job_id) > 2000
ORDER BY job_listing DESC
LIMIT 10;


/*Find the top 5 companies for salary transparency.
They must have more than 500 postings where the salary is explicitly listed
(Salary not null).Limit this to only US jobs.
*/

SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count,
    ROUND(AVG(salary_year_avg), 0) AS salary_average
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE 
    jpf.job_country = 'United States' 
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 500
ORDER BY posting_count DESC
LIMIT 5;
    