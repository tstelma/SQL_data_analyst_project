/*
Time Trends – Analysis Objective

Goal:
Analyze how the demand for key skills in Data Analyst
job postings has evolved over time.

Focus:
Track changes in skill frequency across multiple years
to identify growth, stability, or decline in demand.

Approach:
Group job postings by year and skill, then count
occurrences to observe trends over time.

Purpose:
Understand the direction of the job market by identifying
which skills are becoming more important, which remain
stable, and which are losing relevance.

Note:
This analysis focuses on trend patterns rather than
absolute values, aiming to highlight meaningful changes
in demand across the observed time period.
*/

SELECT
    EXTRACT(YEAR FROM j.job_posted_date) AS job_year,
    s.skills,
    COUNT(*) AS skill_count
FROM
    job_postings_fact AS j
JOIN skills_job_dim AS sj 
    ON sj.job_id = j.job_id
JOIN skills_dim AS s 
    ON s.skill_id = sj.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    job_year,
    s.skills
ORDER BY
    job_year,
    skill_count DESC;

/*
Time Trends – Adjustment Note

The first version returned all skills across all years,
including many low-frequency skills with little analytical value.

To make the trend analysis clearer, the query is narrowed to
the most relevant skills only. This helps focus on meaningful
market movements rather than noise from rare skills.
*/

SELECT
    EXTRACT(YEAR FROM j.job_posted_date) AS job_year,
    s.skills,
    COUNT(*) AS skill_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
    AND s.skills IN (
        'sql',
        'excel',
        'python',
        'tableau',
        'power bi',
        'r',
        'sas',
        'snowflake',
        'azure',
        'aws',
        'databricks'
    )
GROUP BY
    job_year,
    s.skills
ORDER BY
    s.skills,
    job_year;

/*
Time Trends – Normalization Adjustment

Raw skill counts can be affected by differences in the total
number of job postings collected for each year.

To avoid misleading conclusions, this analysis compares each
skill count against the total number of Data Analyst postings
within the same year.

This creates a demand ratio, showing how common each skill is
relative to that year’s job market size rather than relying
only on absolute counts.
*/

WITH total_jobs_per_year AS (
    SELECT
        EXTRACT(YEAR FROM job_posted_date) AS job_year,
        COUNT(DISTINCT job_id) AS total_jobs
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        job_year
),

skills_per_year AS (
    SELECT
        EXTRACT(YEAR FROM j.job_posted_date) AS job_year,
        s.skills,
        COUNT(*) AS skill_count
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND s.skills IN (
            'sql',
            'excel',
            'python',
            'tableau',
            'power bi',
            'r',
            'sas',
            'snowflake',
            'azure',
            'aws',
            'databricks'
        )
    GROUP BY
        job_year,
        s.skills
)

SELECT
    spy.job_year,
    spy.skills,
    spy.skill_count,
    tj.total_jobs,
    ROUND(spy.skill_count * 1.0 / tj.total_jobs, 4) AS demand_ratio
FROM skills_per_year AS spy
INNER JOIN total_jobs_per_year AS tj
    ON spy.job_year = tj.job_year
ORDER BY
    spy.skills,
    spy.job_year;

/*
Time Trends – Normalized Skill Demand Insights

Normalization confirms that differences in total job postings
significantly impact raw counts, making ratio-based analysis
essential for accurate interpretation.

Core tools such as SQL, Python, Tableau, and Excel remain the
most dominant skills, but all show a gradual decline in demand
ratio over time. This indicates that while their absolute usage
is growing, their relative importance within the skill stack is
becoming more diluted.

Excel shows a temporary peak in 2024 before dropping sharply
in 2025, suggesting a shift away from traditional tools toward
more advanced or specialized technologies.

Python, R, and SAS all display a consistent downward trend in
relative demand, indicating reduced emphasis on standalone
statistical tools in favor of broader data ecosystems.

Cloud and modern data platform skills such as AWS, Azure, and
Snowflake remain relatively stable, with slight fluctuations,
while Databricks stands out as a clear growth skill with a
steady increase in demand ratio across all years.

Power BI maintains a stable presence, showing resilience and
consistent relevance in the business intelligence space.

Overall, the market is evolving from reliance on a few dominant
tools toward a more diversified and ecosystem-driven skill set,
with emerging technologies gradually gaining relative importance.
*/