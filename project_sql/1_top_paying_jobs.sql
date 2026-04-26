/*
Top Paying Jobs – Analysis Objective

Goal:
Identify the highest-paying Data Analyst roles
based on average yearly salary.

Focus:
Only include job postings with available salary data
to ensure accurate comparisons.

Dataset:
Covers job postings from 2023 to 2025,
providing a stable, multi-year perspective.

Purpose:
Establish a salary benchmark for Data Analyst roles
and support further analysis of skills and market trends.
*/

SELECT
    j.job_id,
    j.job_title,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date::DATE,
    c.name AS company_name
FROM
    job_postings_fact AS j
LEFT JOIN company_dim AS c ON j.company_id = c.company_id 
WHERE
    j.job_title_short = 'Data Analyst' AND
    j.salary_year_avg IS NOT NULL
ORDER BY
    j.salary_year_avg DESC
LIMIT 10;

/*

Analysis Note:

The results highlight the highest recorded salaries for Data Analyst roles,
but include extreme outliers and potentially misclassified positions.

Several listings appear duplicated with identical salaries, suggesting
reposted roles rather than distinct opportunities.

Top-paying entries are often tied to specialized domains (e.g. ERP,
marketing analytics, GIS) or senior-level responsibilities, rather than
standard Data Analyst positions.

Therefore, these results should be interpreted as salary extremes,
not as representative of typical market compensation.

The query has to be adjusted.

*/

/*
Salary Bands – Analysis Objective

Goal:
Group Data Analyst salaries into defined ranges
to understand how compensation is distributed
across the market.

Focus:
Move beyond extreme values and individual listings
by analyzing the concentration of salaries within
realistic earning ranges.

Approach:
Use predefined salary bands to categorize job postings
and measure how frequently each range occurs.

Purpose:
Identify the most common salary levels,
highlight the true market “center”, and assess
how rare higher-paying roles actually are.
*/

WITH salary_bands AS (
    SELECT
        CASE
            WHEN j.salary_year_avg < 60000 THEN '< 60k'
            WHEN j.salary_year_avg >= 60000 AND j.salary_year_avg < 80000 THEN '60k - 80k'
            WHEN j.salary_year_avg >= 80000 AND j.salary_year_avg < 100000 THEN '80k - 100k'
            WHEN j.salary_year_avg >= 100000 AND j.salary_year_avg < 120000 THEN '100k - 120k'
            WHEN j.salary_year_avg >= 120000 AND j.salary_year_avg < 150000 THEN '120k - 150k'
            ELSE '150k+'
        END AS salary_band
    FROM job_postings_fact AS j
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
)

SELECT
    salary_band,
    COUNT(*) AS job_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM salary_bands
GROUP BY salary_band
ORDER BY
    job_count DESC,
    CASE
        WHEN salary_band = '< 60k' THEN 1
        WHEN salary_band = '60k - 80k' THEN 2
        WHEN salary_band = '80k - 100k' THEN 3
        WHEN salary_band = '100k - 120k' THEN 4
        WHEN salary_band = '120k - 150k' THEN 5
        WHEN salary_band = '150k+' THEN 6
    END;

/*
Analysis Summary:

The salary distribution indicates that the Data Analyst job market
is strongly centered around mid-range compensation levels.

Approximately 70% of roles fall within the 60k to 120k range,
establishing this interval as the most realistic earning expectation.

The most common salary band is 80k to 100k, reflecting a high
concentration of mid-level positions.

In contrast, salaries above 150k account for only a small portion
of the market (around 8%), highlighting their limited availability.

Overall, the results show that while extreme high salaries exist,
they do not represent typical market conditions. Instead, the
Data Analyst role is characterized by a stable and balanced
salary structure concentrated in the mid-range.
*/

   