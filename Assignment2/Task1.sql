SELECT d.department_name "department_name",
       DECODE((SELECT COUNT(*) 
                 FROM employees e
                WHERE e.department_id = d.department_id),
               0,'N/A',(SELECT COUNT(*) 
                          FROM employees e
                         WHERE e.department_id = d.department_id)) "emp_cnt",
       DECODE((SELECT COUNT(distinct e.job_id) 
                 FROM employees e 
                WHERE e.department_id = d.department_id),
               0,'N/A',(SELECT COUNT(distinct e.job_id) 
                          FROM employees e
                         WHERE e.department_id = d.department_id)) "job_cnt",
       NVL(TO_CHAR((SELECT SUM(e.salary)
                      FROM employees e 
                     WHERE e.department_id = d.department_id)), 'N/A') "sum_sal",
       NVL(TO_CHAR((SELECT MIN(e.salary)
                      FROM employees e 
                     WHERE e.department_id = d.department_id) 
                   +(SELECT MAX(e.salary)
                       FROM employees e 
                      WHERE e.department_id = d.department_id)), 'N/A') "sum_min_max",
        (SELECT LISTAGG(e.phone_number, ', ') 
                WITHIN GROUP(ORDER BY e.salary ASC)
          FROM employees e 
         WHERE e.department_id = d.department_id) "phone_numbers"
  FROM departments d LEFT JOIN locations l ON l.location_id = d.location_id
                     LEFT JOIN countries c ON c.country_id = l.country_id
 WHERE INSTR(d.department_name, ' ') = 0
   AND INSTR(LOWER(c.country_name),LOWER(c.country_id)) = 1
ORDER BY c.country_id ASC, c.country_name DESC;
