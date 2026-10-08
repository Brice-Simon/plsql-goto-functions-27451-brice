# plsql-goto-functions-27451-brice
# PL/SQL Assignment III: GOTO Statements and Functions — Nsabimana Simon Brice (ID: 27451)

## Overview

This repository documents the completion of Assignment III, covering three parts in Oracle PL/SQL:

1. Using `GOTO` statements, including an illegal `GOTO` and its fix
2. Creating stored functions and using them together in one `SELECT`
3. Writing a payroll validation function with a test script

## Oracle Environment Used

* Database: Oracle Database 21c
* Architecture: Multitenant, working inside the PDB `br_pdb_27451`
* User: `brice_plsqlauca_27451` (connection name `assignment3`)
* Platform: Microsoft Windows x86 64-bit
* Tools: Oracle SQL Developer, Git and GitHub

## Repository Structure

* `00_setup/` — `create_tables.sql` (creates and fills `departments` and `employees`)
* `01_goto/` — `A1_number_classifier.sql`, `A2_salary_review.sql`, `A3_illegal_goto.sql`, `A4_no_goto.sql`
* `02_functions/` — `B1_fn_annual_salary.sql`, `B2_fn_years_of_service.sql`, `B3_fn_calculate_tax.sql`, `B4_fn_dept_name.sql`, `C1_fn_validate_payroll.sql`
* `03_tests/` — `B5_functions_in_select.sql`, `test_functions.sql`, `test_validate_payroll.sql`
* `screenshots/` — output screenshots (setup screenshots are in `screenshots/setup/`)
* `docs/` — `REFLECTION.md`

## How to Run

1. Connect as `brice_plsqlauca_27451` (service `br_pdb_27451`).
2. Run `00_setup/create_tables.sql` with F5. It drops and recreates the tables, so it can be rerun safely.
3. Run each file in `02_functions/` with F5. Each should report that the function compiled.
4. Run the files in `01_goto/` with F5. Each starts with `SET SERVEROUTPUT ON;`.
5. Run the files in `03_tests/`.

## Setup: Tables and Sample Data

The `departments` and `employees` tables were created with a foreign key, then filled with 4 departments and 7 employees. The `salary` column is a monthly amount in RWF. The data includes edge cases on purpose:

* Jean (106) has a `NULL` salary.
* Paul (107) has no department.
* Marketing has no location.

The script ran twice with no errors, which shows it can be rerun.

Evidence:

![Connection success](screenshots/setup/00_connection_success.png)
![Environment check](screenshots/setup/00_environment_check.png)
![PDB name check](screenshots/setup/00_pdb_name_check.png)
![Setup script output](screenshots/setup/00_setup_script_output.png)
![Setup script output, second run](screenshots/setup/00_setup_script_output_2.png)
![Setup rerun OK](screenshots/setup/00_setup_rerun_ok.png)
![Departments table](screenshots/setup/00_departments_table.png)
![Employees table](screenshots/setup/00_employees_table.png)

## Part A: GOTO Programs

* `A1_number_classifier.sql` — classifies a number as positive, negative or zero, then even or odd, using `GOTO`.
* `A2_salary_review.sql` — reads an employee's salary and uses `GOTO` to jump to the label for that salary band, where the review message for the band is printed.
* `A3_illegal_goto.sql` — Part 1 jumps into an `IF` block and fails with `PLS-00375`. Part 2 fixes it by jumping to a label outside the block.
* `A4_no_goto.sql` — A1 rewritten with `IF / ELSIF / ELSE` and no `GOTO`.

PL/SQL does not allow a `GOTO` to jump into an `IF` block or any nested block from outside. A `GOTO` can only jump to a label in the same block or an enclosing one.

Evidence:

![A1 output](screenshots/A1_output.png)
![A2 output](screenshots/A2_output.png)
![A3 error and fix](screenshots/A3_error_and_fix.png)
![A4 output](screenshots/A4_output.png)

## Part B: Functions

* `fn_annual_salary(monthly)` — monthly salary × 12. A `NULL` salary returns 0.
* `fn_years_of_service(hire_date)` — `TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)`. A `NULL` hire date returns `NULL`.
* `fn_calculate_tax(annual)` — progressive tax on annual salary. A `NULL` salary returns 0.
* `fn_dept_name(dept_id)` — looks up the department name. A missing or `NULL` ID raises `NO_DATA_FOUND`, which is caught and returns `'Unknown department'`.

Tax brackets (each rate applies only to the slice of income inside its bracket):

| Annual income (RWF) | Rate |
|---|---|
| 0 to 2,400,000 | 0% |
| 2,400,001 to 6,000,000 | 10% |
| 6,000,001 to 12,000,000 | 20% |
| Above 12,000,000 | 30% |

Example: an annual income of 14,400,000 pays 360,000 + 1,200,000 + 720,000 = 2,280,000.

Each function was compiled with no errors. `B5_functions_in_select.sql` calls all four functions in one `SELECT` for every employee, and `test_functions.sql` tests normal and edge-case inputs.

Evidence:

![B1 function created](screenshots/setup/B1_function_created.png)
![B1 test output](screenshots/setup/B1_test_output.png)
![B2 function created](screenshots/setup/B2_function_created.png)
![B3 function created](screenshots/setup/B3_function_created.png)
![B4 function created](screenshots/setup/B4_function_created.png)
![B5 functions in one SELECT](screenshots/B5_select_output.png)
![test_functions output](screenshots/test_functions_output.png)

## Part C: Payroll Validation

`fn_validate_payroll(employee_id)` returns `VALID` or `INVALID: reason`. The checks run in this order and stop at the first failure:

1. Employee does not exist: `INVALID: employee not found`
2. Salary is `NULL`: `INVALID: salary is missing`
3. Salary is 0 or negative: `INVALID: salary must be greater than 0`
4. Salary is above 5,000,000 per month: `INVALID: salary exceeds 5,000,000 monthly limit`
5. Hire date is in the future: `INVALID: hire date is in the future`
6. No department assigned: `INVALID: no department assigned`

With the sample data, employees 101 to 105 are `VALID`, Jean (106) is `INVALID: salary is missing`, Paul (107) is `INVALID: no department assigned`, and employee 999 returns `INVALID: employee not found`. `test_validate_payroll.sql` runs these tests.

Evidence:

![C1 validation results](screenshots/C1_output.png)

## Challenges Faced

**Clone error 400.** The `< >` brackets were left around the repository URL in `git clone`. Removing them fixed it.

![Clone error 400](screenshots/setup/issue1_clone_error_400.png)

**`.png.png` double extension.** Windows hid the real extension, so some screenshots were saved as `.png.png`. They were renamed, committed, and every file name was checked afterwards.

![Double png extension](screenshots/setup/issue2_double_png_extension.png)

**Wrong folder for git commands.** `git remote -v` and `git status` failed with "not a git repository" because they were run outside the repo folder. Running `cd plsql-goto-functions-27451-brice` from `C:\Users\STUDENT` fixed it.

**Wrong content in a saved file.** `B1_fn_annual_salary.sql` once held only the test `SELECT`. The function was restored so the file contains the function alone, and test queries live in `03_tests/`.

**Hidden output.** The Script Output pane was scrolled to the bottom, which cut off the `PLS-00375` line. Enlarging the pane and scrolling to the top fixed it before taking screenshots.

## Notes

AI Assistance was used briefly for guidance on SQL codes and Readme . All scripts were run and tested by me in my own Oracle environment.

## Reflection

See [docs/REFLECTION.md](docs/REFLECTION.md).

## Submission Details

* Repository Link: https://github.com/Brice-Simon/plsql-goto-functions-27451-brice
* Name: Nsabimana Simon Brice
* Student ID: 27451
* Issues Encountered: Yes (see Challenges Faced above and docs/REFLECTION.md)
