/*
Question: What are the most optimal skills for data engineers
        balancing both the demand and salary?
-Create a ranking column that combines demand count
    and median salary to identify the most valuable skills
-Focus only on remote Data Engineer positions with specified
 annual salaries.
-Why?
    This approach highlights skills that balance market demand
    and financial reward. It weights core skills appropriately,
    rather than letting rare, outlier skills distort the results.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.salary_year_avg) AS demand_count,
    MEDIAN(jpf.salary_year_avg) * COUNT(jpf.salary_year_avg) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND job_work_from_home = True
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 25;
 
