CREATE OR REPLACE FUNCTION fn_calculate_tax (
  p_annual_salary IN NUMBER
) RETURN NUMBER
IS
  v_tax NUMBER := 0;
BEGIN
  IF p_annual_salary IS NULL OR p_annual_salary <= 2400000 THEN
    RETURN 0;
  END IF;

  -- 10% on the slice from 2,400,000 to 6,000,000
  v_tax := (LEAST(p_annual_salary, 6000000) - 2400000) * 0.10;

  -- 20% on the slice from 6,000,000 to 12,000,000
  IF p_annual_salary > 6000000 THEN
    v_tax := v_tax + (LEAST(p_annual_salary, 12000000) - 6000000) * 0.20;
  END IF;

  -- 30% on everything above 12,000,000
  IF p_annual_salary > 12000000 THEN
    v_tax := v_tax + (p_annual_salary - 12000000) * 0.30;
  END IF;

  RETURN v_tax;
END fn_calculate_tax;
/