select * from employees;

-- 1
select * from employees
where job_id = 'IT_PROG';

-- 2
select * from employees
where salary >= 5000;

--3
select * from employees
where salary between 5000 and 10000;

--4
select employee_id, first_name, last_name, email from employees
where last_name like 'M%';

--5
select employee_id, first_name, last_name, email from employees
where email like '%AN%';

--6
select distinct job_id from employees;

--7
select * from employees
where manager_id is null;

--8
select * from employees
where commission_pct is not null;

--9
select * from employees
where (job_id = 'FI_ACCOUNT' or  job_id = 'IT_PROG') and salary >= 8000;

--10
select * from employees
order by salary;

--11
select * from employees
order by job_id, salary desc;

--12
select employee_id, email, salary, nvl(commission_pct,0) from employees;

--13
select employee_id, first_name, last_name, first_name || ' ' || last_name as fullname from employees;

--14
select employee_id, first_name, last_name from employees
where length(last_name) <= 5;

--15
select count(*) high_salary_cnt from employees
where salary >= 5000;

--16
select sum(salary) it_prog_salary_sum from employees
where job_id = 'IT_PROG';

--17
select min(hire_date) hire_date_min, max(hire_date) hire_date_max from employees;

--18
select job_id, count(*) job_id_employee_cnt from employees
group by job_id;

--19
select department_id, sum(salary) department_id_salary_sum from employees
where department_id is not null group by department_id;

--20
select department_id, department_id_salary_sum
from(
    select department_id, sum(salary) department_id_salary_sum from employees
    where department_id is not null group by department_id
)
where department_id_salary_sum <= 50000;

