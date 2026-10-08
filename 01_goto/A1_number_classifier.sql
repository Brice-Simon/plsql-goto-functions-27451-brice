SET SERVEROUTPUT ON;

DECLARE
  v_number NUMBER := 7;   -- change to -4 and 0 to test
BEGIN
  DBMS_OUTPUT.PUT_LINE('Checking number: ' || v_number);

  IF v_number > 0 THEN
    GOTO positive_number;
  ELSIF v_number < 0 THEN
    GOTO negative_number;
  ELSE
    GOTO zero_number;
  END IF;

  <<positive_number>>
  DBMS_OUTPUT.PUT_LINE('Sign: positive');
  GOTO check_parity;

  <<negative_number>>
  DBMS_OUTPUT.PUT_LINE('Sign: negative');
  GOTO check_parity;

  <<zero_number>>
  DBMS_OUTPUT.PUT_LINE('Sign: zero');

  <<check_parity>>
  IF MOD(v_number, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Parity: even');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Parity: odd');
  END IF;

  GOTO end_program;

  <<end_program>>
  NULL;
END;
/