/*
Time Trends – Year-over-Year Growth Analysis

Goal:
Measure how the relative demand for each skill changes
between consecutive years.

Approach:
Use normalized demand ratios and calculate the percentage
change from one year to the next.

Purpose:
Identify which skills are gaining importance, which are
declining, and which remain stable over time.

Note:
This analysis builds on normalized demand ratios to ensure
fair comparison across years with different job volumes.
*/

WITH total_jobs_per_year AS (
    SELECT
        EXTRACT(YEAR FROM job_posted_date) AS job_year,
        COUNT(DISTINCT job_id) AS total_jobs
    FROM job_postings_fact as j
    WHERE
        j.job_title_short = 'Data Analyst' AND
        j.salary_year_avg IS NOT NULL
    GROUP BY
        job_year
    ), 

    skills_per_year AS (
    SELECT
        EXTRACT(YEAR FROM j.job_posted_date) AS job_year,
        s.skills,
        COUNT(*) AS skill_count
    FROM job_postings_fact as j
    INNER JOIN skills_job_dim as sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim as s ON sj.skill_id = s.skill_id
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
    ),

    normalized AS (
        SELECT
            spy.job_year,
            spy.skills,
            ROUND(spy.skill_count * 1.0 / tj.total_jobs, 4) AS demand_ratio
        FROM
            skills_per_year AS spy
        JOIN
            total_jobs_per_year AS tj ON  spy.job_year = tj.job_year
    ),

    yoy_growth AS (
        SELECT
            skills,
            job_year,
            demand_ratio,
            LAG(demand_ratio) OVER (PARTITION BY skills ORDER BY job_year) AS prev_year_ratio
        FROM   
            normalized
    )



SELECT
    skills,
    job_year,
    demand_ratio,
    prev_year_ratio,
    ROUND((demand_ratio - prev_year_ratio) / prev_year_ratio * 100, 2) AS yoy_growth_pct
FROM
    yoy_growth
WHERE
    prev_year_ratio IS NOT NULL
ORDER BY 
    skills,
    job_year;

/*
🔍 YEAR-OVER-YEAR (YoY) SKILL DEMAND TRENDS ANALYSIS

This section evaluates how demand for key Data Analyst skills evolves over time,
using normalized demand ratios to account for differences in total job postings per year.

Key Insights:

1. Declining Core Skills (Market Saturation / Standardization)
   - SQL, Python, Tableau, and R all show consistent negative YoY growth.
   - Example: SQL dropped from 56.4% (2023) → 39.3% (2025).
   - Interpretation:
     These skills remain essential, but are becoming baseline expectations rather than differentiators.

2. Traditional Tools Losing Relative Share
   - Excel shows a sharp rise in 2024 (+19.9%) followed by a major drop in 2025 (-36.7%).
   - SAS and R continue a steady decline across both years.
   - Interpretation:
     Legacy and traditional analytics tools are gradually losing relevance in modern workflows.

3. Emerging / High-Growth Technologies
   - Databricks shows strong and consistent growth (+34.6% → +26.9%).
   - Snowflake and Azure recover in 2025 after earlier declines.
   - Interpretation:
     Cloud-based and big data platforms are gaining traction and becoming increasingly valuable.

4. Stable / Resilient Skills
   - Power BI remains relatively stable with slight fluctuations (-4.3% → +7.3%).
   - Interpretation:
     Visualization tools maintain steady demand as they are critical for business reporting.

5. Transitional Trends in Cloud Ecosystem
   - AWS shows continuous decline, while Azure rebounds in 2025.
   - Interpretation:
     Possible shift in employer preference or diversification across cloud platforms.


Overall Conclusion:

The market is shifting from:
   → Core technical skills (SQL, Python, Excel)

Towards:
   → Ecosystem-based and platform-driven skills (Databricks, Snowflake, Azure)

This suggests that:
   - Foundational skills are necessary but no longer sufficient for differentiation.
   - Career growth increasingly depends on specialization in modern data infrastructure tools.

*/



