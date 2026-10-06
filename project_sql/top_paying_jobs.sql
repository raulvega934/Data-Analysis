/* Questions
What are the top paying Data Analyst jobs ?
- top 10 paying Data Analyst jobs in the Arizona area or remote jobs
-Why? Provide exploratory analysis of Data Analyst jobs in Arizona/ remote 
*/

WITH analyst_remote_jobs AS(
    SELECT *,
    CASE WHEN salary_rate = 'hour' AND job_schedule_type = 'Full-time' THEN salary_hour_avg * 2080 
    WHEN salary_rate = 'year' THEN salary_year_avg
    END AS annual_salary   
    FROM job_postings_fact
    WHERE job_location ='Anywhere'
    AND job_title_short ILIKE '%Data Analyst%'
)

SELECT company_dim.name AS company_name, 
job_title_short, job_location, annual_salary, job_id
FROM analyst_remote_jobs
INNER JOIN company_dim
ON analyst_remote_jobs.company_id = company_dim.company_id
WHERE annual_salary IS NOT NULL
ORDER BY annual_salary DESC
LIMIT 10;