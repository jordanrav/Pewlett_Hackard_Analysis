CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(40) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


SELECT ep.emp_no,
	ep.first_name,
	ep.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as ep
LEFT JOIN titles as ti
ON ep.emp_no = ti.emp_no
ORDER BY ep.emp_no;

SELECT * FROM retirement_titles;
	


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
ep.emp_no,
	ep.first_name,
	ep.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO unique_titles
FROM employees as ep
LEFT JOIN titles as ti
ON ep.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (to_date BETWEEN '9999-01-01' AND '9999-01-01') 
ORDER BY emp_no;

SELECT 
	COUNT(ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC; 

SELECT DISTINCT ON (emp_no)
	ep.emp_no,
	ep.first_name,
	ep.last_name,
	ep.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as ep
INNER JOIN dept_emp as de
	ON ep.emp_no = de.emp_no
INNER JOIN titles as ti
	ON ep.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date BETWEEN '9999-01-01' AND '9999-01-01')
ORDER BY emp_no;
	

SELECT * FROM mentorship_eligibility






