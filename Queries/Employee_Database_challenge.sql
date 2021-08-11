SELECT emp_no, first_name, last_name
FROM employees;

SELECT title,from_date,to_date
FROM titles;


-----Create table with employee names and their titles
drop table retirement_titles;

SELECT emp.emp_no, emp.first_name, emp.last_name, ti.title,
       ti.from_date, ti.to_date 
INTO retirement_titles
FROM employees emp INNER JOIN titles ti
ON emp.emp_no = ti.emp_no
where emp.birth_date between '1952-01-01' and '1955-12-31'
;

SELECT * 
FROM retirement_titles
order by emp_no;


----Remove duplicate entries of Employees with most recent titles
DROP TABLE  unique_titles;

SELECT DISTINCT ON (emp_no)
 emp_no,first_name,last_name,title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

SELECT *
from unique_titles;

--count the number of employees per title who are about to retire
SELECT count(emp_no),title 
INTO retiring_titles
FROM public.unique_titles
group by title
order by count(emp_no) desc;

SELECT *
FROM retiring_titles;


----Create Mentorship eligibility query 
SELECT DISTINCT ON (emp.emp_no)
	emp.emp_no, emp.first_name,emp.last_name,emp.birth_date,demp.from_date,demp.to_date,ti.title
INTO mentorship_eligibilty	
FROM employees emp INNER JOIN dept_emp demp    
ON emp.emp_no = demp.emp_no
INNER JOIN titles ti
ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date between '1965-01-01' and '1965-12-31')
	and demp.to_date = '9999-01-01'
ORDER BY emp.emp_no ASC,
ti.to_date DESC

SELECT *
FROM mentorship_eligibilty;

