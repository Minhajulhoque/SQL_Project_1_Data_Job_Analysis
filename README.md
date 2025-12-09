# Introduction

This project provides a structured analysis of the current data job market 📊, focusing specifically on Data Analyst roles. It examines the highest-paying opportunities 💼, the most in-demand skills 🔍, and the intersection between market demand and salary competitiveness 💡.

#### Explore the complete set of SQL queries here: [data_job_analysis](/data_job_analysis/)

# Background

Motivated by the objective of navigating the Data Analyst job market more efficiently 📊, this project was developed to identify the highest-paying roles and the most sought-after skills. The goal is to streamline the process for others seeking to determine the most advantageous career opportunities 💼.

The dataset is sourced from Luke Barousse's **[SQL Course](https://www.lukebarousse.com/sql)** 📚, offering detailed information on job titles, compensation, locations, and required competencies.

### Key Research Questions Addressed through SQL Analysis

1. What are the top-paying Data Analyst positions?
2. What skills are required for the top-paying Data Analyst positions?
3. What are the most in-demand skills for Data Analysts?
4. What are the highest-value skills based on salary impact?
5. What are the most advantageous skills to develop?

# Tools Utilized

To conduct a comprehensive analysis of the Data Analyst job market, several core technologies were employed:

- **SQL:** Served as the primary analytical framework, enabling efficient querying and extraction of key insights from the dataset.

- **PostgreSQL:** Utilized as the database management system, providing a robust environment for handling and processing job posting data.

- **Visual Studio Code:** Functioned as the main interface for database interaction and execution of SQL queries.

- **Git & GitHub:** Applied for version control, documentation, and repository management, supporting seamless collaboration and project oversight.

# Analysis Overview

Each SQL query in this project was designed to examine a distinct dimension of the Data Analyst job market. The following outlines the approach taken to address each research question:

#### 1 Top-Paying Data Analyst Positions
To identify the most lucrative opportunities, Data Analyst roles were filtered by average annual salary and restricted to remote positions. This query highlights the ten highest-compensated remote roles, providing a clear view of the top-paying opportunities within the field.

```sql
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
```

- **Wide Salary Range:** The ten highest-paying Data Analyst roles offer annual compensation ranging from $184,000 to $650,000, highlighting substantial earning potential within the field.

- **Diverse Employers:** Leading companies, including SmartAsset, Meta, and AT&T, feature among the top-paying employers, reflecting strong demand for analytics expertise across multiple industries.

- **Variety of Job Titles:** Positions span a range of roles, from Data Analyst to Director of Analytics, demonstrating the breadth of responsibilities and specializations available in the data analytics domain.

![Top Paying Jobs](https://github.com/Minhajulhoque/SQL_Project_1_Data_Job_Analysis/blob/main/assets/top_paying_positions.png)

*Bar graph illustrating the top 10 highest salaries for data analysts, generated from SQL query results using Gemini.*

#### 2 Top 10 Most In-Demand Skills & Top 10 Skills by Associated Salary
To identify the skills demanded by top-paying roles, I joined job postings with associated skills data, providing insights into the competencies valued by employers for high-compensation positions.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

- **Core Competencies:** SQL, Python, and Tableau are the most commonly requested skills, forming the core "tech stack" for these data roles.

- **High-Value Niches:** While less frequent, specific tools like Databricks, PySpark, and Hadoop are linked to higher average salaries, suggesting a premium for big data and engineering-heavy skill sets.

- **Tool Diversity:** The list includes a mix of programming languages (Python, R, Go), databases/big data (SQL, Snowflake, Hadoop), and visualization tools (Tableau, Power BI), highlighting the multi-faceted nature of these high-level data positions.

![Top 10 in-demand skills](https://github.com/Minhajulhoque/SQL_Project_1_Data_Job_Analysis/blob/main/assets/Code_Generated_Image_2.png)

*Bar graph illustrating the top 10 in-demand skills, generated from SQL query results using Gemini.*

![Top 10 Skills by Associated Salary](https://github.com/Minhajulhoque/SQL_Project_1_Data_Job_Analysis/blob/main/assets/Code_Generated_Image.png)

*Bar graph illustrating the top 10 skills by associated salary, generated from SQL query results using Gemini.*


#### 3 Top Skills by Demand Count
To identify the skills demanded by top-paying roles, I joined job postings with associated skills data, providing insights into the competencies valued by employers for high-compensation positions. The following analysis shows the top 5 skills based on their demand count, revealing the most sought-after competencies.

```SQL
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
```

- **SQL is the most in-demand skill** (7,291), significantly leading all others. This highlights the foundational importance of SQL for data querying and management across various roles.

- **Data Analysis Tools are highly valued:** Excel (4,611) and Python (4,330) occupy the second and third spots, indicating a high demand for a mix of traditional data analysis capabilities (Excel) and more advanced data manipulation and scripting (Python).

- **Visualization Tools are Essential:** The two main business intelligence (BI) tools, Tableau (3,745) and Power BI (2,609) complete the top five. The higher demand for Tableau suggests it may be the preferred visualization tool in the context of this data.

| Rank | Skill | Demand Count | Insight |
| :---: | :--- | :---: | :--- |
| **1** | **SQL** | 7,291 | **Foundation of Data:** Significantly leads the pack, highlighting the critical and fundamental role of SQL for data querying and management. |
| **2** | **Excel** | 4,611 | **Universal Tool:** Strong demand for traditional data analysis, reporting, and quick data manipulation tasks, proving its enduring value. |
| **3** | **Python** | 4,330 | **Advanced Analytics:** Highly sought after for scripting, complex data science, statistical modeling, and automation tasks. |
| **4** | **Tableau** | 3,745 | **BI Visualization:** Higher demand than Power BI in this dataset, indicating a preference for its robust and flexible data visualization capabilities. |
| **5** | **Power BI** | 2,609 | **Business Intelligence:** Completes the top 5, demonstrating the need for dashboard creation and data presentation skills. |

---


#### Top 10 Skills by Average Salary
To determine which technical skills drive high compensation, this analysis was generated by associating individual skills with the average annual salary of job postings that require them, providing clear insights into the competencies valued most by employers for high-compensation positions.

```sql
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
```

| skills | avg_salary |
| :--- | :--- |
| pyspark | 208172.3 |
| bitbucket | 189154.5 |
| watson | 160515 |
| couchbase | 160515 |
| datarobot | 155485.5 |
| gitlab | 154500 |
| swift | 153750 |
| jupyter | 152776.5 |
| pandas | 151821.3 |
| golang | 145000 |
| elasticsearch | 145000 |
| numpy | 143512.5 |
| databricks | 141906.6 |
| linux | 136507.5 |
| kubernetes | 132500 |
| atlassian | 131161.8 |
| twilio | 127000 |
| airflow | 126103 |
| scikit-learn | 125781.3 |
| jenkins | 125436.3 |
| notion | 125000 |
| scala | 124903 |
| postgresql | 123878.8 |
| gcp | 122500 |
| microstrat | 121619.3 |
| crystal | 120100 |
| go | 115319.9 |
| confluence | 114209.9 |
| db2 | 114072.1 |
| hadoop | 113192.6 |

- **PySpark is the Top Earning Skill:** The skill with the highest average salary is PySpark, commanding an average of $208,172. This suggests that expertise in distributed computing and big data processing is extremely valuable.

- **DevOps/Collaboration Tools Pay Well:** Bitbucket is the second-highest skill with an average salary of $189,154. This highlights the high value placed on development operations and version control expertise.

- **High-End Specialized Skills:** The top three are rounded out by Watson and Couchbase, both at an average of $160,515. These are specialized skills in AI/cognitive computing and NoSQL databases, respectively, indicating a premium for niche, high-demand expertise.

- **Data Science/ML Frameworks:** Skills like DataRobot and popular Python libraries like Pandas and NumPy also feature prominently, with average salaries ranging from $143,512 to $155,486, solidifying the high value of data-centric roles.


#### Most Optimal Skills
Combining insights from demand and salary data, this analysis was generated to pinpoint skills that are both in high demand and yield high average salaries, offering a strategic focus for skill development aimed at maximizing career opportunities and compensation.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS demand_count
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
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG (salary_year_avg), 2) AS avg_salary
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
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.Skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 
    30;
```

| skill_id | skills      | demand_count | avg_salary  |
|----------|------------|--------------|------------|
| 8        | go         | 27           | 115,319.89 |
| 234      | confluence | 11           | 114,209.91 |
| 97       | hadoop     | 22           | 113,192.57 |
| 80       | snowflake  | 37           | 112,947.97 |
| 74       | azure      | 34           | 111,225.10 |
| 77       | bigquery   | 13           | 109,653.85 |
| 76       | aws        | 32           | 108,317.30 |
| 4        | java       | 17           | 106,906.44 |
| 194      | ssis       | 12           | 106,683.33 |
| 233      | jira       | 20           | 104,917.90 |
| 79       | oracle     | 37           | 104,533.70 |
| 185      | looker     | 49           | 103,795.30 |
| 2        | nosql      | 13           | 101,413.73 |
| 1        | python     | 236          | 101,397.22 |
| 5        | r          | 148          | 100,498.77 |
| 78       | redshift   | 16           | 99,936.44  |
| 187      | qlik       | 13           | 99,630.81  |
| 182      | tableau    | 230          | 99,287.65  |
| 197      | ssrs       | 14           | 99,171.43  |
| 92       | spark      | 13           | 99,076.92  |
| 13       | c++        | 11           | 98,958.23  |
| 186      | sas        | 63           | 98,902.37  |
| 7        | sas        | 63           | 98,902.37  |
| 61       | sql server | 35           | 97,785.73  |
| 9        | javascript | 20           | 97,587.00  |
| 183      | power bi   | 110          | 97,431.30  |
| 0        | sql        | 398          | 97,237.16  |
| 215      | flow       | 28           | 97,200.00  |
| 201      | alteryx    | 17           | 94,144.53  |
| 199      | spss       | 24           | 92,169.68  |

- **High-Demand Programming Languages:** Python and R demonstrate exceptional demand, with demand counts of 236 and 148, respectively. While their average salaries are approximately $101,397 for Python and $100,499 for R, these figures indicate that proficiency in these languages is highly sought after, though widely available within the labor market.

- **Cloud Platforms and Big Data Technologies:** Expertise in specialized tools such as Snowflake, Azure, AWS, and BigQuery exhibits strong demand alongside relatively high average compensation. This trend underscores the increasing importance of cloud infrastructure and big data technologies in modern data analytics and enterprise environments.

- **Business Intelligence and Data Visualization:** Tools such as Tableau and Looker, with demand counts of 230 and 49 and average salaries of $99,288 and $103,795 respectively, highlight the strategic value of data visualization and business intelligence in translating complex datasets into actionable insights.

- **Database Technologies:** The sustained demand for skills in both traditional and NoSQL databases—including Oracle, SQL Server, and NoSQL—accompanied by average salaries ranging from $97,786 to $104,534, reflects the critical need for expertise in data storage, retrieval, and management in contemporary analytics workflows.

# Key Learnings

During this project, I significantly enhanced my SQL capabilities, including:

- **Advanced Query Development:** Gained expertise in constructing complex queries, integrating multiple tables, and leveraging WITH clauses for efficient temporary table operations.

- **Data Aggregation:** Developed proficiency with GROUP BY and aggregate functions such as COUNT() and AVG(), enabling effective summarization and analysis of datasets.

- **Analytical Problem-Solving:** Strengthened the ability to translate real-world questions into precise, actionable SQL queries, delivering clear and insightful data-driven solutions.


# Conclusions

### Insights
The analysis revealed several key observations:

- **Top-Paying Data Analyst Roles:** Remote data analyst positions show substantial salary variation, with the highest reaching $650,000.

- **Critical Skills for High Earnings:** Advanced SQL proficiency is a defining requirement for the top-paying roles, emphasizing its importance for candidates aiming for upper-tier compensation.

- **Most Sought-After Skill:** SQL also emerges as the most frequently requested skill across the market, reinforcing its essential role for job seekers.

- **High-Value Specialized Skills:** Niche competencies such as SVN and Solidity command the highest average salaries, reflecting strong market premiums for specialized expertise.

- **Optimal Market-Value Skills:** With both high demand and strong earning potential, SQL stands out as one of the most strategically valuable skills for maximizing career opportunities in data analytics.

### Closing Thoughts
This analysis strengthened my SQL capabilities and offered meaningful insights into the data analyst employment landscape. The results provide a practical framework for prioritizing skill development and job search strategies. By focusing on high-demand and high-compensation skills, aspiring data analysts can improve their competitiveness in the field. The project underscores the need for continuous learning and responsiveness to evolving industry trends.
