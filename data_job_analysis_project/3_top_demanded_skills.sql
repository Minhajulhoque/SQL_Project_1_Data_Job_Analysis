/*
Question: What are the most in-demand skills for Data Analysts?

- Conduct an inner join comparable to the second query across all postings.
- Identify the five most frequently listed skills.

Objective: To determine the core capabilities most consistently sought across the broader labor market.
*/

SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
