/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opportunities for Data Analysts 
*/

SELECT
job_id,
job_title,
job_location,
job_schedule_type,
c.name as company_name,
salary_year_avg,
job_posted_date
FROM
job_postings_fact j
LEFT JOIN company_dim c ON c.company_id = j.company_id
WHERE
job_title_short = 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg is not null
order BY
salary_year_avg desc
limit 10;
