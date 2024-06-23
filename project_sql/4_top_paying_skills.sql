/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focus on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps
identify the most financially rewarding skills to acquire or improve
*/


SELECT 
s.skills,
round(avg(t.salary_year_avg),1) as average_salary
FROM
job_postings_fact t
INNER JOIN skills_job_dim sj on t.job_id = sj.job_id
INNER JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE
job_title_short = 'Data Analyst' AND
salary_year_avg is not NULL
GROUP BY
skills
order BY
average_salary desc
limit 25;