/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrate on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
SELECT
s.skill_id, 
s.skills,
count(sj.job_id) as demand_count
FROM
job_postings_fact t
INNER JOIN skills_job_dim sj on t.job_id = sj.job_id
INNER JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE
job_title_short = 'Data Analyst' AND
salary_year_avg is not NULL AND
job_work_from_home = TRUE
GROUP BY
s.skill_id
), average_salary as (
SELECT
s.skill_id, 
s.skills,
round(avg(t.salary_year_avg),1) as avg_salary
FROM
job_postings_fact t
INNER JOIN skills_job_dim sj on t.job_id = sj.job_id
INNER JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE
job_title_short = 'Data Analyst' AND
salary_year_avg is not NULL AND
job_work_from_home = TRUE
GROUP BY
s.skill_id
)

SELECT
sd.skill_id,
sd.skills,
demand_count,
avg_salary
from
skills_demand sd
inner join average_salary avs on sd.skill_id = avs.skill_id
WHERE
demand_count > 50 AND avg_salary > 100000
ORDER BY
avg_salary desc;

-- rewriting this query more concisely
SELECT
s.skill_id, 
s.skills,
count(sj.job_id) as demand_count,
round(avg(t.salary_year_avg), 1) as avg_salary
FROM
job_postings_fact t
INNER JOIN skills_job_dim sj on t.job_id = sj.job_id
INNER JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE
job_title_short = 'Data Analyst' AND
salary_year_avg is not NULL AND
job_work_from_home = TRUE
GROUP BY
s.skill_id
HAVING
count(sj.job_id) > 50 AND round(avg(t.salary_year_avg), 1) > 100000
ORDER BY
avg_salary desc;