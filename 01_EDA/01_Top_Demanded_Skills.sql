SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';

/*
Question: What are the most in-demand skills for Data enginners?
-Identify the top 10 in-demand skills for data enginners.
-Focus on remote job postings.
-Why? Retrieves the top 10 skills with the highest demand in the remote job market
    providing insights into most valuable skills for data engineers seeking remote work.
*/

SELECT
    sd.skills AS skills,
    COUNT(jpf.*) AS demand_count,
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND job_work_from_home = True
GROUP BY sd.skills
ORDER BY COUNT(jpf.*) DESC
LIMIT 10;

/*
────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/