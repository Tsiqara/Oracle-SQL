SELECT SUBSTR(j.job_id, 1, INSTR(j.job_id, '_') - 1) "pref",
       COUNT(e.job_id) "count",
       DECODE(COUNT(e.job_id), 0,'N', 'Y') "yn",
       AVG(e.salary) "avg_salary",
       COUNT(CASE WHEN e.hire_date BETWEEN '01-JAN-2002' AND '31-DEC-2002' THEN 1 ELSE NULL END) "cnt_2002"
  FROM jobs j JOIN employees e ON j.job_id = e.job_id
GROUP BY SUBSTR(j.job_id, 1, INSTR(j.job_id, '_') - 1)
ORDER BY CASE SUBSTR(j.job_id, 1, INSTR(j.job_id, '_') - 1) WHEN 'IT' THEN 1
                                                            WHEN 'MK' THEN 2
         ELSE 3 END, AVG(e.salary)DESC;
