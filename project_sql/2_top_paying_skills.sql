/*
Top Paying Skills – Analysis Objective

Goal:
Calculate the average salary associated with each skill
across Data Analyst job postings.

Focus:
Avoid relying on only the top-paying listings,
which may contain duplicates or salary outliers.

Approach:
Join job postings with skill data,
group results by skill,
and calculate average salary per skill.

To improve reliability,
only include skills appearing in a minimum number
of job postings.
*/

SELECT
    s.skills,
    COUNT(*) AS skill_demand,
    ROUND(AVG(j.salary_year_avg), 0) AS avg_salary

FROM
    job_postings_fact AS j

INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id

INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id

WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL

GROUP BY
    s.skills

HAVING
    COUNT(*) >= 10

ORDER BY
    avg_salary DESC

LIMIT 25;

/*
Analysis Summary:

The highest-paying skills associated with Data Analyst roles
are primarily advanced technical tools rather than traditional
analysis skills.

Top results are dominated by machine learning frameworks,
data engineering technologies, and cloud/infrastructure tools
(e.g. Hugging Face, Terraform, Kafka, Spark, Snowflake).

This indicates that higher salaries are strongly linked to roles
that extend beyond standard data analysis into engineering,
machine learning, and large-scale data processing.

A clear trade-off is observed between demand and salary:
highly specialized skills offer greater compensation but appear
in fewer job postings, while more common skills tend to have
lower average salaries.

Overall, the findings suggest that core analytical tools serve
as baseline requirements, while cross-domain expertise is the
key driver of higher compensation in Data Analyst roles.
*/

