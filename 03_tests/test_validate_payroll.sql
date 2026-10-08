SELECT employee_id,
       first_name || ' ' || last_name AS full_name,
       fn_validate_payroll(employee_id) AS payroll_status
FROM employees
ORDER BY employee_id;

SELECT fn_validate_payroll(999) AS unknown_employee FROM dual;