SET SERVEROUTPUT ON;

DECLARE
  v_number NUMBER := 7;   -- same value as A1
  v_sign   VARCHAR2(10);
  v_parity VARCHAR2(10);
BEGIN
  IF v_number > 0 THEN
    v_sign := 'positive';
  ELSIF v_number < 0 THEN
    v_sign := 'negative';
  ELSE
    v_sign := 'zero';
  END IF;

  IF MOD(v_number, 2) = 0 THEN
    v_parity := 'even';
  ELSE
    v_parity := 'odd';
  END IF;

  DBMS_OUTPUT.PUT_LINE(v_number || ' is ' || v_sign || ' and ' || v_parity);
END;
/