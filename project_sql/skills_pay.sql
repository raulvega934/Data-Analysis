/* Finding the average salary for skills for Data Analyst jobs
- regardless of location and salary rate, we want to find the average salary for skills required for Data Analyst jobs
*/

SELECT skills,ROUND(AVG(T.salary_year_avg),2) AS average_salary
FROM  job_postings_fact AS T
JOIN skills_job_dim AS SJ
ON T.job_id = SJ.job_id
JOIN skills_dim AS SD
ON SJ.skill_id = SD.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;