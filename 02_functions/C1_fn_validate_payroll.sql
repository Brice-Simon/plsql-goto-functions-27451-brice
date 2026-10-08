CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_employee_id IN NUMBER
) RETURN VARCHAR2
IS
  v_salary    employees.salary%TYPE;
  v_hire_date employees.hire_date%TYPE;
  v_dept      employees.department_id%TYPE;
BEGIN
  SELECT salary, hire_date, department_id
    INTO v_salary, v_hire_date, v_dept
    FROM employees
   WHERE employee_id = p_employee_id;

  IF v_salary IS NULL THEN
    RETURN 'INVALID: salary is missing';
  ELSIF v_salary <= 0 THEN
    RETURN 'INVALID: salary must be greater than 0';
  ELSIF v_salary > 5000000 THEN
    RETURN 'INVALID: salary exceeds 5,000,000 monthly limit';
  ELSIF v_hire_date > SYSDATE THEN
    RETURN 'INVALID: hire date is in the future';
  ELSIF v_dept IS NULL THEN
    RETURN 'INVALID: no department assigned';
  END IF;

  RETURN 'VALID';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: employee not found';
END fn_validate_payroll;
/   