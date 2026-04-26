/*
Skill Complementarity – Analysis Objective

Goal:
Identify which skills most frequently appear together
in Data Analyst job postings.

Focus:
Analyze skill combinations rather than individual skills
to better reflect real-world job requirements.

Approach:
Examine co-occurrence of skills within the same job postings
to uncover common and highly demanded skill pairings.

Purpose:
Understand how different tools and technologies are combined
in practice, revealing typical skill stacks expected by employers.

Note:
This analysis shifts the focus from isolated skill importance
to relationships between skills, providing deeper insight into
how competencies interact within the Data Analyst role.
*/


SELECT
    s1.skills AS skill_1,
    s2.skills AS skill_2,
    COUNT(*) AS pair_count
FROM
    skills_job_dim AS sj1

INNER JOIN skills_job_dim AS sj2
    ON sj1.job_id = sj2.job_id
    AND sj1.skill_id < sj2.skill_id

INNER JOIN skills_dim as s1
    ON sj1.skill_id = s1.skill_id

INNER JOIN skills_dim as s2
    ON sj2.skill_id = s2.skill_id

INNER JOIN job_postings_fact as j 
    ON sj1.job_id = j.job_id

WHERE
    j.job_title_short = 'Data Analyst' AND
    j.salary_year_avg IS NOT NULL

GROUP BY
    s1.skills,
    s2.skills
ORDER BY
    pair_count DESC
LIMIT
    25;

/*
Analysis Summary:

The results reveal strong patterns of skill complementarity
within Data Analyst job postings.

SQL emerges as the central hub skill, appearing in the majority
of high-frequency skill combinations and connecting with both
analytical and visualization tools.

The most common skill stack consists of SQL, Python, and
a visualization tool such as Tableau or Power BI, reflecting
a balanced requirement for data extraction, analysis, and
presentation.

Analytical programming languages (Python, R, SAS) frequently
appear together, indicating overlap and flexibility in advanced
analysis tasks.

Business tools such as Excel, Word, and PowerPoint form a
separate cluster, reinforcing their role as baseline
competencies rather than differentiating skills.

Overall, the findings highlight that Data Analyst roles are
defined by integrated skill sets rather than isolated tools,
emphasizing the importance of combining multiple competencies
in real-world job requirements.
*/