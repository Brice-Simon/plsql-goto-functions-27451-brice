CREATE OR REPLACE FUNCTION fn_years_of_service (
  p_hire_date IN DATE
) RETURN NUMBER
IS
BEGIN
  IF p_hire_date IS NULL THEN
    RETURN NULL;
  END IF;

  RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, p_hire_date) / 12);
END fn_years_of_service;
/