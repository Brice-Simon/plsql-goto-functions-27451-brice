SET SERVEROUTPUT ON;

-- fn_annual_salary
SELECT fn_annual_salary(1000000) AS normal,
       fn_annual_salary(0)       AS zero,
       fn_annual_salary(NULL)    AS null_input
FROM dual;

-- fn_years_of_service
SELECT fn_years_of_service(DATE '2015-03-01') AS long_service,
       fn_years_of_service(SYSDATE)           AS just_hired,
       fn_years_of_service(NULL)              AS null_input
FROM dual;

-- fn_calculate_tax (one value in each bracket and on the boundaries)
SELECT fn_calculate_tax(2000000)  AS bracket_0,
       fn_calculate_tax(2400000)  AS boundary_0,
       fn_calculate_tax(5000000)  AS bracket_10,
       fn_calculate_tax(8000000)  AS bracket_20,
       fn_calculate_tax(15000000) AS bracket_30,
       fn_calculate_tax(NULL)     AS null_input
FROM dual;

-- fn_dept_name
SELECT fn_dept_name(10)   AS valid_dept,
       fn_dept_name(999)  AS missing_dept,
       fn_dept_name(NULL) AS null_input
FROM dual;