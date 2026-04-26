/*
Skill Strategy Matrix – Final Analysis Objective

Goal:
Classify Data Analyst skills based on their strategic value
using insights from demand, salary, trends, and complementarity.

Focus:
Move beyond ranking skills individually and group them into
practical categories that explain their role in the job market.

Approach:
Use previous analyses to identify which skills act as baseline
requirements, salary boosters, growing technologies, or declining
legacy tools.

Purpose:
Provide a final market interpretation that connects all previous
sections and translates the findings into a clear skill strategy.
*/

SELECT DISTINCT
    skills,

    CASE
        WHEN skills IN ('sql', 'excel') THEN 'Core Foundation'
        WHEN skills IN ('python', 'tableau', 'power bi') THEN 'High-Value Analyst Stack'
        WHEN skills IN ('snowflake', 'databricks', 'azure', 'aws') THEN 'Modern Data Platform Boosters'
        WHEN skills IN ('r', 'sas') THEN 'Legacy / Statistical Tools'
        WHEN skills IN ('word', 'powerpoint', 'sheets') THEN 'Business Support Tools'
        ELSE 'Other'
    END AS skill_category,

    CASE
        WHEN skills IN ('sql', 'excel') THEN
            'Highly demanded baseline skills required for most Data Analyst roles.'
        WHEN skills IN ('python', 'tableau', 'power bi') THEN
            'Strong practical skills combining demand, salary, and complementarity.'
        WHEN skills IN ('snowflake', 'databricks', 'azure', 'aws') THEN
            'Modern platform skills linked to data infrastructure and higher salaries.'
        WHEN skills IN ('r', 'sas') THEN
            'Legacy analytical tools with declining relative demand.'
        WHEN skills IN ('word', 'powerpoint', 'sheets') THEN
            'Business tools supporting communication and reporting.'
        ELSE
            'Other'
    END AS strategic_interpretation,

    CASE
        WHEN skills IN ('sql', 'excel') THEN 1
        WHEN skills IN ('python', 'tableau', 'power bi') THEN 2
        WHEN skills IN ('snowflake', 'databricks', 'azure', 'aws') THEN 3
        WHEN skills IN ('r', 'sas') THEN 4
        WHEN skills IN ('word', 'powerpoint', 'sheets') THEN 5
        ELSE 6
    END AS sort_order

FROM skills_dim

WHERE skills IN (
    'sql','excel','python','tableau','power bi',
    'snowflake','databricks','azure','aws',
    'r','sas',
    'word','powerpoint','sheets'
)

ORDER BY
    sort_order,
    skills;

/*
FINAL CONCLUSION

The Data Analyst skill landscape can be structured into clear layers:

- Core Foundation:
  SQL and Excel remain essential entry requirements.

- High-Value Stack:
  Python and BI tools (Tableau, Power BI) provide strong analytical leverage
  and are widely used across roles.

- Modern Data Platforms:
  Tools like Snowflake, Databricks, and cloud services are gaining importance
  and offer strong specialization opportunities.

- Legacy Tools:
  R and SAS show declining relative demand, indicating a shift in industry preferences.

- Business Tools:
  Communication tools remain relevant but do not drive technical differentiation.

Key Takeaway:
The most effective strategy is to build a strong core foundation,
layer practical analytics tools on top, and selectively specialize
in modern data platforms.
*/