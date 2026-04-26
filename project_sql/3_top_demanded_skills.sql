/*
Top 5 Demanded Skills – Analysis Objective

Goal:
Identify the most frequently requested skills in
Data Analyst job postings.

Focus:
Measure demand by counting how often each skill
appears across relevant job listings.

Approach:
Aggregate job-skill relationships and rank skills
based on their occurrence frequency.

Filter:
Limit analysis to remote Data Analyst roles to
ensure consistency with earlier sections.

Purpose:
Highlight the core skill set required by employers
and establish the baseline competencies expected
in the Data Analyst job market.
*/


WITH top_demanded as (

SELECT 
    skill_id,
    count(*) as skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact as job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

 SELECT 
    skills as skill_demanded,
    skill_count

FROM top_demanded
INNER JOIN skills_dim as skills ON skills.skill_id = top_demanded.skill_id

ORDER BY
    skill_count DESC

limit 5;

/*
Analysis Summary:

The results reveal a clear hierarchy of the most demanded
skills in Data Analyst job postings.

SQL is the most frequently requested skill by a significant
margin, confirming its role as the fundamental requirement
for data-related tasks.

Excel ranks second, highlighting its continued importance
as a core business and data manipulation tool.

Python emerges as the leading programming language,
reflecting the growing demand for advanced analytical
capabilities.

Visualization tools such as Tableau and Power BI are also
widely required, emphasizing the importance of data
presentation and communication.

Overall, the findings indicate that Data Analyst roles
require a balanced combination of data extraction,
analysis, and visualization skills, forming a stable
and consistent core skill set.
*/