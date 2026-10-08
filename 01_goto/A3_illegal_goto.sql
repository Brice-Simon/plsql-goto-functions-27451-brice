SET SERVEROUTPUT ON;

-- PART 1: ILLEGAL. GOTO jumps INTO an IF block.
DECLARE
  v_number NUMBER := 5;
BEGIN
  GOTO inside_if;

  IF v_number > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

-- PART 2: FIXED. The label is outside the IF block.
DECLARE
  v_number NUMBER := 5;
BEGIN
  IF v_number > 0 THEN
    GOTO positive_label;   -- jumping OUT of an IF is legal
  END IF;

  DBMS_OUTPUT.PUT_LINE('Number is not positive');
  GOTO finish;

  <<positive_label>>
  DBMS_OUTPUT.PUT_LINE('Fixed: jumped to a label outside the IF block');

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Done');
END;
/