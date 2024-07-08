Drop table if exists salaries;
Drop table if exists dept_emp;
Drop table if exists dept_manager;
Drop table if exists departments;
Drop table if exists employees;
Drop table if exists titles;
	

Create table titles (
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR
);

Select * from titles


Create table employees (
	emp_no VARCHAR PRIMARY KEY NOT NULL,
	emp_title VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

SELECT * from employees


Create table departments (
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR
);

Select * from departments


Create table dept_manager(
	dept_no VARCHAR NOT NULL,
	emp_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

Select * from dept_manager


Create table dept_emp(
	emp_no VARCHAR NOT NULL,
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

Select * from dept_emp


Create table salaries(
	emp_no VARCHAR PRIMARY KEY NOT NULL,
	salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

Select * from salaries



-- List the employee number, last name, first name, sex, and salary of each employee
Select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
From employees
Left Join salaries On employees.emp_no = salaries.emp_no;


-- List the first name, last name, and hire date for the employees who were hired in 1986
Select employees.first_name, employees.last_name, employees.hire_date
From employees
Where
	hire_date >= '01/01/1986'
	AND hire_date <= '12/31/1986';


-- List the manager of each department along with their department number, department name, employee number, last name, and first name
Select dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
From dept_manager
Inner Join departments on dept_manager.dept_no = departments.dept_no
Inner Join employees on dept_manager.emp_no = employees.emp_no;


-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
Select dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
From dept_emp
Inner Join departments on dept_emp.dept_no = departments.dept_no
Inner Join employees on dept_emp.emp_no = employees.emp_no;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
Select employees.first_name, employees.last_name, employees.sex
From employees
Where	
	first_name = 'Hercules'
	AND last_name Like 'B%';


-- List each employee in the Sales department, including their employee number, last name, and first name
Select dept_emp.emp_no, employees.last_name, employees.first_name
From dept_emp
Inner Join employees on dept_emp.emp_no = employees.emp_no
Where dept_no = 'd007';


-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
Select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
From dept_emp
Inner join employees ON dept_emp.emp_no = employees.emp_no
Inner join departments ON dept_emp.dept_no = departments.dept_no
Where
	dept_name = 'Sales'
	OR dept_name = 'Development'



-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
Select last_name, count(last_name) as "frequency"
From employees
Group by last_name
Order by "frequency" DESC;