/*
Question: How do Arizona and remote Data Analyst jobs compare?
- Group postings into 'Remote' vs 'Arizona'
- Count postings, count postings with a listed salary, and compute average and median annual salary
- Uses the same annual salary logic as the earlier queries
- Helps decide whether to target local or remote roles
*/

WITH analyst_jobs AS (
    SELECT
        job_id,
        CASE
            WHEN job_location = 'Anywhere' THEN 'Remote'
            ELSE 'Arizona'
        END AS location_group,
        CASE
            WHEN salary_rate = 'hour' AND job_schedule_type = 'Full-time' THEN salary_hour_avg * 2080
            WHEN salary_rate = 'year' THEN salary_year_avg
        END AS annual_salary
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
      AND (job_location = 'Anywhere'
           OR job_location ILIKE '%, AZ'
           OR job_location ILIKE '%Arizona%')
)

SELECT
    location_group,
    COUNT(*) AS total_postings,
    COUNT(annual_salary) AS postings_with_salary,
    ROUND(AVG(annual_salary), 0) AS avg_salary,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_salary)::numeric, 0) AS median_salary,
    MAX(annual_salary) AS max_salary
FROM analyst_jobs
GROUP BY location_group
ORDER BY avg_salary DESC;