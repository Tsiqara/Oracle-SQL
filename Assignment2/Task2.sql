SELECT j.job_id "job_id",
       j.job_title "name",
       DECODE((SELECT COUNT(*)
                 FROM employees e
                WHERE e.job_id = j.job_id
                  AND MOD(e.employee_id, 2) = 1),
               0,'N/A',(SELECT COUNT(*)
                          FROM employees e
                         WHERE e.job_id = j.job_id
                           AND MOD(e.employee_id, 2) = 1)) "emp_cnt",
       NVL(TO_CHAR((SELECT AVG(e.salary)
                      FROM employees e
                     WHERE e.job_id = j.job_id
                     AND MOD(e.employee_id, 2) = 0)),'N/A') "avg_sal",
       DECODE((SELECT COUNT(*)
                 FROM employees e
                WHERE e.job_id = j.job_id
                  AND e.salary = (SELECT MAX(e.salary)
                                    FROM employees e
                                  WHERE e.job_id = j.job_id)),
               0,'N/A',(SELECT COUNT(*)
                          FROM employees e
                         WHERE e.job_id = j.job_id
                           AND e.salary = (SELECT MAX(e.salary)
                                             FROM employees e
                                            WHERE e.job_id = j.job_id))) "mx_cnt" 
  FROM jobs j
 WHERE LENGTH(j.job_id) >= 4
   AND (j.max_salary - j.min_salary) <> (SELECT MAX(j.max_salary - j.min_salary)
                                           FROM jobs j)
ORDER BY CASE WHEN INSTR(j.job_id, 'IT') <> 0 THEN 1
              ELSE 2 END, j.job_id ASC;
