/*
Question1: What top-paying skills for Data Engineers (remote jobs)
Identify the 10 skills with the highest median salary.
Focus only on remote postings.
Why? Helps reveal which skills bring the most financial value in remote work.
*/

SELECT
    sd.skills AS skill_name,
    MEDIAN(jpf.salary_year_avg) AS median_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Engineer'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
GROUP BY sd.skills
ORDER BY median_salary DESC
LIMIT 20;


/*Question2: Most in-demand programming languages for Data Scientists
Find the top 10 programming languages mentioned in job postings.
Restrict to remote Data Scientist roles.
Why? Shows which languages dominate the remote data science market.
*/

SELECT
    sd.skills AS skill,
    COUNT(jpf.*) AS dount_posting
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND job_country = 'Kenya'
GROUP BY sd.skills
ORDER BY COUNT(jpf.*) DESC
LIMIT 10;