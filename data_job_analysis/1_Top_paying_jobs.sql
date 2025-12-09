/*
Question: What are the top-paying Data Analyst positions?

- Identify the ten highest-compensated remote Data Analyst roles.
- Include only postings with explicitly stated salary information.

Objective: To present a clear overview of the most financially competitive opportunities available to Data Analysts in the remote job market.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short ='Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;