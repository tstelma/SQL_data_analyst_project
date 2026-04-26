with remote_jobs_skills as (


SELECT 
    skill_id,
    count(*) as skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact as job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = true 
    AND job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

 SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count

FROM remote_jobs_skills
INNER JOIN skills_dim as skills ON skills.skill_id = remote_jobs_skills.skill_id

ORDER BY
    skill_count DESC

limit 5;


--------- SUBQUERIES ----------



-- SUBQUERIES PROBLEM 1 SOLVED --

SELECT skills_dim.skills 
FROM 
    skills_dim
INNER JOIN (
    SELECT 
        skill_id,
        count(job_id) as skill_count
    FROM   
        skills_job_dim
    GROUP BY 
        skill_id,
    ORDER BY 
        count(job_id) DESC
    LIMIT 5
)

as top_skills on skills_dim.skill_id = top_skills.skill_id
ORDER by 
    top_skills.skill_count desc;




-- SUBQUERIES PROBLEM 2 SOLVED --

SELECT 
    company_id,
    name,
    number_of_postings,


    CASE 
        WHEN number_of_postings < 10 THEN 'Small'
        WHEN number_of_postings >= 10 AND number_of_postings < 50 THEN 'Medium'
        WHEN number_of_postings >= 50 THEN 'Large'
    END AS size_category

FROM (
    

    SELECT 
        company_dim.company_id,
        company_dim.name,              
        COUNT(job_id) AS number_of_postings  

    FROM company_dim

    LEFT JOIN job_postings_fact 
        ON company_dim.company_id = job_postings_fact.company_id

    GROUP BY company_dim.company_id,
             company_dim.name

) AS company_counts   


job_postings_fact as j 
company_dim as c 
skills_dim as s 
skills_job_dim as sj




-- SUBQUERIES PROBLEM 3 --

/* 
The average salary for each company.

The single overall average salary across all jobs.

The names of the companies.
*/


SELECT 
    company_dim.name,
    company_salaries.avg_salary
FROM 
    company_dim
LEFT JOIN (
    SELECT 
    company_id,
    avg(salary_year_avg) as avg_salary
FROM
    job_postings_fact 
GROUP BY
    company_id) as company_salaries on company_dim.company_id = company_salaries.company_id

WHERE
    company_salaries.avg_salary > 
    (SELECT
    avg(salary_year_avg)
FROM
    job_postings_fact );

-- another solution -- 

SELECT name,
FROM company_dim
WHERE company_id IN (
SELECT company_id
FROM job_postings_fact
GROUP BY company_id
HAVING AVG(salary_year_avg) > (
SELECT AVG(salary_year_avg)
FROM job_postings_fact
)
)


-- find companies with more than 500 job postings and avg yearly salary over 100k --
-- retun company names + avg salary --

SELECT 
name,
avg(j.salary_year_avg) as avg_yearly_sal

FROM    
    company_dim as c

left JOIN job_postings_fact as j on c.company_id = j.company_id

GROUP BY
    c.name
HAVING 
    count(j.job_id) > 500
    and avg(j.salary_year_avg) > 100000
ORDER BY
    avg_yearly_sal DESC;


-- CTE PROBLEMS -- 


-- problem 1 --

with jobs_per_company as (
    SELECT 
        company_id,
        COUNT(distinct (job_title)) as distinct_jobs_count
    FROM
        job_postings_fact
    GROUP BY
        company_id 
)
SELECT 
    company_dim.name as company_name,
    jobs_per_company.distinct_jobs_count
FROM
    company_dim
left JOIN jobs_per_company on company_dim.company_id = jobs_per_company.company_id
ORDER BY
   distinct_jobs_count DESC 
LIMIT 10;


-- problem 2 --

--Define a CTE to calculate the average salary for each country. 

with avg_salary_country as (
    SELECT
    job_country,
    avg(salary_year_avg) as avg_country_salary
    FROM job_postings_fact
    GROUP BY
    job_country
    ORDER by 
    avg_country_salary desc
)
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_country,
    company_dim.name,
    job_postings_fact.salary_year_avg as salary_rate,
    CASE
        WHEN job_postings_fact.salary_year_avg < avg(avg_salary_country.avg_country_salary) THEN 'Above average'
        else 'Below average'
    END as salary_category,
    extract(month from job_postings_fact.job_posted_date) as month_posted
FROM job_postings_fact

INNER JOIN avg_salary_country on job_postings_fact.job_country = avg_salary_country.job_country
INNER JOIN company_dim on job_postings_fact.company_id = company_dim.company_id

GROUP BY
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_country,
    company_dim.name,
    avg_salary_country.avg_country_salary
ORDER BY
    month_posted desc;

-- problem 3 --

with required_skills as (
    SELECT
    c.name,
    c.company_id, 
    count(distinct sj.skill_id) as required_skills
    FROM company_dim as c
    left JOIN job_postings_fact as j on c.company_id = j.company_id
    left JOIN skills_job_dim as sj on j.job_id = sj.job_id
    GROUP BY
        c.company_id
),

highest_salary as (
    SELECT
    c.name,
    c.company_id,
    max(j.salary_year_avg) as max_salary
    FROM company_dim as c
    INNER JOIN job_postings_fact as j on j.company_id = c.company_id
    GROUP BY    
    c.company_id
)
    
SELECT
    c.name,
    required_skills.required_skills,
    highest_salary.max_salary
FROM
    company_dim as c
LEFT JOIN required_skills on required_skills.company_id = c.company_id
LEFT JOIN highest_salary on highest_salary.company_id = c.company_id
WHERE
   highest_salary.max_salary is not null
 

ORDER BY c.name;

----------------- UNIONS ---------------

SELECT
    job_title_short,
    company_id,
    job_location
from
    january_jobs

UNION all

SELECT
    job_title_short,
    company_id,
    job_location
from
    february_jobs

UNION all

SELECT
    job_title_short,
    company_id,
    job_location
from
    march_jobs

----- PROBLEM 1 -----

/*
Find job postings from the first quarter that have salary greater than 70k
- Combine job posting tables from first quarter of 2023 
- Get job postings with an average yearly salary > 70k
*/



SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::date,
    quarter1_job_postings.salary_year_avg
from (
SELECT *
from january_jobs
UNION all
SELECT *
from february_jobs
UNION all
SELECT *
from march_jobs
) as quarter1_job_postings
WHERE  
    quarter1_job_postings.salary_year_avg > 70000 and
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg desc;


------ PROBLEM 2 -----

/*
- Create a unified query categorizing job postings into two groups
 those With Salary Info and those Without Salary Info.

- Return job_id, job_title, and a new column named salary_info

*/

SELECT
    job_id,
    job_title,
    'With Salary Info' as salary_info
from
    job_postings_fact
WHERE
    salary_year_avg is not null
    or salary_hour_avg is not null

UNION all

SELECT
    job_id,
    job_title,
    'Without Salary Info' as salary_info
from
    job_postings_fact
WHERE
    salary_year_avg is null
    AND salary_hour_avg is null
ORDER BY
    job_id;

------- PROBLEM 3 -------


SELECT
    Q1.job_id,
    Q1.job_title_short,
    Q1.job_location,
    Q1.job_via,
    Q1.salary_year_avg,
    s.skills,
    s.type
from (
    SELECT *
        from january_jobs
    UNION all
    SELECT *
        from february_jobs
    UNION all
    SELECT *
        from march_jobs
) as Q1
    
left JOIN skills_job_dim as sj on Q1.job_id = sj.job_id
LEFT JOIN skills_dim as s on sj.skill_id = s.skill_id

where 
    Q1.salary_year_avg > 70000
ORDER BY
    Q1.job_id;

----- PROBLEM 4 ------

SELECT
    
    extract(year FROM Q1.job_posted_date) as posted_year,
    extract(month FROM Q1.job_posted_date) as posted_month,
    COUNT(Q1.job_id) as skill_count,
    s.skills
    
from (
    SELECT *
        from january_jobs
    UNION all
    SELECT *
        from february_jobs
    UNION all
    SELECT *
        from march_jobs
) as Q1

left JOIN skills_job_dim as sj on Q1.job_id = sj.job_id
LEFT JOIN skills_dim as s on sj.skill_id = s.skill_id

GROUP BY
    s.skills,
    posted_year,
    posted_month
ORDER BY
    skill_count desc;