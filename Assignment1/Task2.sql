SELECT e.first_name || ' ' || e.last_name "full_name",
       TO_CHAR(e.salary, 'fm$999,999,999.00') "salary",
       NVL(SUBSTR(e.email, 1, INSTR(e.email, '@') - 1), 'INVALID MAIL') "mail",
       e.email, -- ისედაც email- ში სახელის პირველი ასო და გვარი წერია. არსად არ არის @. გამოდის ყველა არასწორია?
       TO_CHAR(e.salary * (MONTHS_BETWEEN(TRUNC(sysdate, 'Month'), TRUNC(sysdate, 'Year'))), 'fm$999,999,999,999.00') "Salary in this year",
       NVL(TO_CHAR(e.commission_pct, '0.00'), 'No Com') "Commision"
  FROM employees e
 WHERE (e.department_id = 50 OR MONTHS_BETWEEN(SYSDATE, e.hire_date) >= 5 * 12)
   AND e.phone_number LIKE '515%'
   AND e.job_id NOT IN ('IT_PROG', 'PU_CLERK')
   AND e.salary BETWEEN 5000 AND 10000
   AND e.manager_id IS NOT NULL
ORDER BY e.salary DESC, e.hire_date;
