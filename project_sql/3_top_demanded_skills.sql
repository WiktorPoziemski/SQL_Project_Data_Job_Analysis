/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers
*/

SELECT 
s.skills,
count(sj.job_id) as demand_count
FROM
job_postings_fact t
INNER JOIN skills_job_dim sj on t.job_id = sj.job_id
INNER JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE
job_title_short = 'Data Analyst'
GROUP BY
skills
order BY
demand_count desc
limit 5;