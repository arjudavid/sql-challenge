--Creating tables with their columns and adding values and NOTNULL specifications.

CREATE TABLE "departments" (
    "dept_no" VARCHAR(5) NOT NULL,
    "dept_name" VARCHAR(30) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE "salaries" (
    "emp_no" INT NOT NULL,
    "salary" INT NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(7) NOT NULL,
    "title" VARCHAR(30) NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE "employees" (
    "emp_no" INT NOT NULL,
    "emp_title_id" VARCHAR(7) NOT NULL,
    "birth_date" DATE NOT NULL,
    "first_name" VARCHAR(30) NOT NULL,
    "last_name" VARCHAR(30) NOT NULL,
    "sex" VARCHAR(1) NOT NULL,
    "hire_date" DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);

CREATE TABLE "dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR(5) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(5) NOT NULL,
    "emp_no" INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (dept_no, emp_no)
);


--Listing the employee number, last name, first name, sex, and salary of each employee.

SELECT 
    e.emp_no AS "Employee #", 
    e.last_name AS "Last Name", 
    e.first_name AS "First Name", 
    e.sex AS "Sex",
    s.salary AS "Salary"
FROM 
    employees e
JOIN 
    salaries s 
ON 
    e.emp_no = s.emp_no;

--Listing the first name, last name, and hire date for the employees who were hired in 1986.

SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    hire_date AS "Hire Date"
FROM 
    employees
WHERE 
    hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Listing the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT 
    dm.dept_no AS "Department #",
    d.dept_name AS "Department Name",
    dm.emp_no AS "Employee #",
    e.last_name AS "Last Name",
    e.first_name AS "First Name"
FROM 
    dept_manager dm
JOIN 
    departments d
ON 
    dm.dept_no = d.dept_no
JOIN 
    employees e
ON 
    dm.emp_no = e.emp_no;

--Listing the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT 
    dm.dept_no AS "Department #",
    d.dept_name AS "Department Name",
    dm.emp_no AS "Employee #",
    e.last_name AS "Last Name",
    e.first_name AS "First Name"
FROM 
    dept_manager dm
JOIN 
    departments d
ON 
    dm.dept_no = d.dept_no
JOIN 
    employees e
ON 
    dm.emp_no = e.emp_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    sex AS "Sex"
FROM 
    employees
WHERE 
    first_name = 'Hercules' 
    AND last_name LIKE 'B%';

--Listing each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
    e.emp_no AS "Employee #",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM 
    employees e
JOIN 
    dept_emp de
ON 
    e.emp_no = de.emp_no
JOIN 
    departments d
ON 
    de.dept_no = d.dept_no
WHERE 
    d.dept_name = 'Sales';

--Listing each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
    e.emp_no AS "Employee #",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
    d.dept_name AS "Department Name"
FROM 
    employees e
JOIN 
    dept_emp de
ON 
    e.emp_no = de.emp_no
JOIN 
    departments d
ON 
    de.dept_no = d.dept_no
WHERE 
   d.dept_name IN ('Sales', 'Development');


--Listing the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT 
    last_name AS "Last Name", 
    COUNT(*) AS "Frequency Count" 
FROM 
    employees
GROUP BY 
    last_name
ORDER BY 
    "Frequency Count" DESC;
