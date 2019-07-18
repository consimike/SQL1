-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/B41vWP
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "department" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "bith_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



-- Queries

-- 1)
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
	FROM employees AS e
	INNER JOIN salaries AS s
	ON e.emp_no = s.emp_no;

-- 2)
SELECT * 
	FROM employees
	WHERE hire_date >= '1986-01-01';

-- 3)

SELECT m.dept_no, m.emp_no, d.dept_name,e.last_name, e.first_name, m.from_date, m.to_date
	FROM dept_manager AS m
	INNER JOIN department AS d
	ON m.dept_no = d.dept_no
	INNER JOIN employees AS e
	ON m.emp_no = e.emp_no;

-- 4)
-- employee number, last name, first name, and department name.
CREATE VIEW question4 AS
	SELECT e.emp_no, e.last_name, e.first_name, de.dept_no
		FROM employees AS e
		INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no;

SELECT q.emp_no, q.last_name, q.first_name, d.dept_name
	FROM question4 AS q
	INNER JOIN department AS d
	ON q.dept_no = d.dept_no;
	
	
-- 5)
-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
	FROM employees
	WHERE first_name = 'Hercules' 
	AND last_name LIKE 'B%';
	
-- 6)
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT q.emp_no, q.last_name, q.first_name, d.dept_name
	FROM question4 AS q
	INNER JOIN department AS d
	ON q.dept_no = d.dept_no
	WHERE d.dept_name = 'Sales';
   
-- 7)
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT q.emp_no, q.last_name, q.first_name, d.dept_name
	FROM question4 AS q
	INNER JOIN department AS d
	ON q.dept_no = d.dept_no
	WHERE d.dept_name = 'Sales'
	OR d.dept_name = 'Development';
	
-- 8)
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name)
	FROM employees
	GROUP BY last_name
	ORDER BY COUNT(last_name) DESC;









