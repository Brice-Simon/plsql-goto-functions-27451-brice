SELECT e.employee_id,
       e.first_name || ' ' || e.last_name           AS full_name,
       fn_dept_name(e.department_id)                AS department,
       e.salary                                     AS monthly_salary,
       fn_annual_salary(e.salary)                   AS annual_salary,
       fn_years_of_service(e.hire_date)             AS years_of_service,
       fn_calculate_tax(fn_annual_salary(e.salary)) AS annual_tax
FROM employees e
ORDER BY e.employee_id;