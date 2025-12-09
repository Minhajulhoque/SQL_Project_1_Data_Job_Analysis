/*
Question: What are the highest-value skills based on salary impact?

- Compute the average salary associated with each skill across Data Analyst listings.
- Restrict analysis to roles with disclosed compensation.

Objective: To assess the salary-enhancing effect of specific skills and identify competencies associated with elevated earning potential.
*/

SELECT 
    skills,
    ROUND(AVG (salary_year_avg), 2)  AS avg_salary
FROM 
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 30;

/*
Key Insights on Salary-Differentiating Skills

- Advanced analytics, big data, and machine learning expertise are strongly correlated with top-tier compensation.
- Software development and deployment capabilities elevate both role complexity and salary potential.
- Cloud technologies and modern data engineering platforms demonstrate a consistent association with higher remuneration.

[
  {
    "skills": "pyspark",
    "avg_salary": "208172.25"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189154.50"
  },
  {
    "skills": "watson",
    "avg_salary": "160515.00"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155485.50"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500.00"
  },
  {
    "skills": "swift",
    "avg_salary": "153750.00"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152776.50"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821.33"
  },
  {
    "skills": "golang",
    "avg_salary": "145000.00"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000.00"
  },
  {
    "skills": "numpy",
    "avg_salary": "143512.50"
  },
  {
    "skills": "databricks",
    "avg_salary": "141906.60"
  },
  {
    "skills": "linux",
    "avg_salary": "136507.50"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500.00"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131161.80"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000.00"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103.00"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781.25"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436.33"
  },
  {
    "skills": "notion",
    "avg_salary": "125000.00"
  },
  {
    "skills": "scala",
    "avg_salary": "124903.00"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123878.75"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500.00"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619.25"
  },
  {
    "skills": "crystal",
    "avg_salary": "120100.00"
  },
  {
    "skills": "go",
    "avg_salary": "115319.89"
  },
  {
    "skills": "confluence",
    "avg_salary": "114209.91"
  },
  {
    "skills": "db2",
    "avg_salary": "114072.13"
  },
  {
    "skills": "hadoop",
    "avg_salary": "113192.57"
  }
] 
*/