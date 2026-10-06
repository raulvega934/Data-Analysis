/* Questions
What are the skills required for the top paying Data Analyst jobs?
- use the top 10 jobs from previous query to find the skills required for those jobs
- add the specific skills required for those jobs to the output of the previous query
- helps us understand what skills are in demand for Data Analyst jobs
*/

WITH analyst_remote_jobs AS(
    SELECT *,
    CASE WHEN salary_rate = 'hour' AND job_schedule_type = 'Full-time' THEN salary_hour_avg * 2080 
    WHEN salary_rate = 'year' THEN salary_year_avg
    END AS annual_salary   
    FROM job_postings_fact
    WHERE job_location ='Anywhere'
    AND job_title_short = 'Data Analyst'
),
top_analyst_jobs AS(
    SELECT company_dim.name AS company_name,analyst_remote_jobs.job_id, 
job_title_short, job_location, annual_salary
FROM analyst_remote_jobs
INNER JOIN company_dim
ON analyst_remote_jobs.company_id = company_dim.company_id
WHERE annual_salary IS NOT NULL
ORDER BY annual_salary DESC
LIMIT 10)
