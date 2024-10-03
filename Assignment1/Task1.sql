SELECT e.first_name || q'[ ' - ' ]' || e.last_name "F and L",
       NVL(d.department_name, 'X') "Department Name",
       m.first_name "Manager Name",
       TO_CHAR(e.salary, '$99,999.00') "Salary",
       mM.First_Name "Manager's Manager Name",
       TO_CHAR(mM.Salary, '$999,99.00') "Manager's Manager Salary"
  FROM employees e 
LEFT OUTER JOIN departments d 
    ON e.department_id = d.department_id
LEFT OUTER JOIN employees m
    ON e.manager_id = m.employee_id
LEFT OUTER JOIN employees mM
    ON m.manager_id = mM.Employee_Id
 WHERE LOWER(mM.First_Name) LIKE '%a%'
   AND MOD(mM.Salary, 17) = 0;
