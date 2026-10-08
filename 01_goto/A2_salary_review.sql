SET SERVEROUTPUT ON;

BEGIN
  FOR r IN (SELECT employee_id, first_name, salary
            FROM employees
            ORDER BY employee_id) LOOP

    DBMS_OUTPUT.PUT_LINE('Employee ' || r.employee_id || ' ' || r.first_name ||
                         ' | monthly salary: ' || NVL(TO_CHAR(r.salary), 'NULL'));

    IF r.salary IS NULL THEN
      GOTO missing_salary;
    ELSIF r.salary < 500000 THEN
      GOTO band_low;
    ELSIF r.salary <= 1500000 THEN
      GOTO band_mid;
    ELSE
      GOTO band_high;
    END IF;

    <<missing_salary>>
    DBMS_OUTPUT.PUT_LINE('Review: salary missing, update the record');
    GOTO next_employee;

    <<band_low>>
    DBMS_OUTPUT.PUT_LINE('Review: low band, eligible for raise review');
    GOTO next_employee;

    <<band_mid>>
    DBMS_OUTPUT.PUT_LINE('Review: mid band, standard review');
    GOTO next_employee;

    <<band_high>>
    DBMS_OUTPUT.PUT_LINE('Review: high band, senior review');

    <<next_employee>>
    DBMS_OUTPUT.PUT_LINE('-----');
  END LOOP;
END;
/