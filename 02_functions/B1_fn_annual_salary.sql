CREATE OR REPLACE FUNCTION fn_annual_salary (
  p_monthly_salary IN NUMBER
) RETURN NUMBER
IS
BEGIN
  IF p_monthly_salary IS NULL THEN
    RETURN 0;
  END IF;

  RETURN p_monthly_salary * 12;
END fn_annual_salary;
/