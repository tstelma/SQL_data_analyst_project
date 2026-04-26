/*
Optimal Skills – Analysis Objective

Goal:
Identify the most optimal skills for Data Analyst roles
by combining both market demand and salary potential.

Focus:
Evaluate each skill based on how frequently it appears
in job postings (demand) and the average salary associated
with it.

Approach:
Calculate demand and average salary separately,
then combine the results to analyze which skills
offer the best balance between availability and compensation.

Filter:
Limit analysis to remote Data Analyst roles with
available salary data to ensure consistency and reliability.

Purpose:
Move beyond isolated metrics and determine which skills
provide the strongest overall value in the job market,
highlighting those that are both widely required and
well compensated.

Note:
This section serves as a synthesis of previous analyses,
bridging the gap between high-demand skills and
high-paying skills.
*/


WITH skills_demand AS (

    SELECT 
        sj.skill_id,
        s.skills,
        count(*) as demand_count
    FROM
        skills_job_dim AS sj
    INNER JOIN job_postings_fact as j ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = TRUE
    GROUP BY
        sj.skill_id,
        s.skills
    ORDER BY demand_count DESC
)

, average_salary AS (

    SELECT
        sj.skill_id,
        s.skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact as j
    INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = TRUE
    GROUP BY
        sj.skill_id,
        s.skills
)

SELECT
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;

/*
Analysis Summary:

The results highlight the most optimal skills by combining
both demand and salary metrics.

The strongest performers are SQL, Python, Tableau, and R,
which offer a balanced combination of high demand and
competitive salaries.

Excel, while highly demanded, shows lower average salary,
indicating its role as a baseline requirement rather than
a differentiating skill.

Specialized tools such as Snowflake, Databricks, and Go
are associated with higher salaries but appear less
frequently, reflecting a trade-off between demand and
compensation.

Overall, the findings demonstrate that the most valuable
skills are those that balance availability and pay,
rather than maximizing a single dimension. A combination
of data querying, programming, and visualization skills
provides the strongest positioning in the Data Analyst
job market.
*/


/*
Adjustment Note:

To enhance the analysis, a combined score is introduced
to balance both demand and salary into a single metric.

This adjustment reduces the dominance of highly frequent
skills and highlights those that offer the best overall
value in terms of market demand and compensation.

The combined score provides a more holistic ranking,
allowing for clearer identification of truly optimal skills.
*/

 WITH skills_demand AS (

    SELECT 
        sj.skill_id,
        s.skills,
        count(*) as demand_count
    FROM
        skills_job_dim AS sj
    INNER JOIN job_postings_fact as j ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = TRUE
    GROUP BY
        sj.skill_id,
        s.skills
    ORDER BY demand_count DESC
)

, average_salary AS (

    SELECT
        sj.skill_id,
        s.skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact as j
    INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
        AND j.job_work_from_home = TRUE
    GROUP BY
        sj.skill_id,
        s.skills
)

SELECT
    skills_demand.skills,
    demand_count,
    avg_salary,
    ROUND(
    ((avg_salary / 1000.0) * LOG(demand_count))::numeric,
    2
) AS combined_score
FROM
    skills_demand
INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id
ORDER BY
    combined_score DESC
LIMIT 25;

/*
Analysis Summary:

The combined score highlights the most optimal skills
by balancing both demand and salary.

SQL ranks as the most valuable skill, offering the
strongest combination of high demand and solid
compensation.

Visualization tools, particularly Tableau, emerge as
highly optimal, slightly outperforming programming
languages when both factors are considered.

Python and R remain strong contributors, reinforcing
the importance of analytical and programming capabilities.

Excel maintains high demand but ranks lower due to
its limited impact on salary, confirming its role as
a baseline requirement.

Specialized tools such as Snowflake, Databricks, and
Jira contribute to higher salaries but appear less
frequently, reflecting a trade-off between demand and
compensation.

Overall, the results demonstrate that the most optimal
skill set is a balanced combination of data querying,
analysis, and visualization, supplemented by selective
technical specializations.
*/