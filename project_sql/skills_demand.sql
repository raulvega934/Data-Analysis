/*
Finding the top skils for Data analyst jobs everywhere in the US
- regardless of location and salary rate, we want to find the top skills required for Data Analyst jobs
*/

SELECT skills,COUNT(T.job_id) AS skill_occurence
FROM  job_postings_fact AS T
JOIN skills_job_dim AS SJ
ON T.job_id = SJ.job_id
JOIN skills_dim AS SD
ON SJ.skill_id = SD.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY skill_occurence DESC
LIMIT 10;
