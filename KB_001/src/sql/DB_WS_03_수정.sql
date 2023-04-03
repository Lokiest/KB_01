
--1. 계좌 ( account ) 테이블을 조회하되, 고객명 ( name) 도 함께 조회한다.

 select account.account_seq, account.account_number, account.balance, account.user_seq, users.name
   from account join users
   on account.user_seq = users.user_seq;


--2. 위 1번 query 를 table alias 를 사용하고, ANSI JOIN 대신 오라클 Join 표기법을 사용한다.

 select a.account_seq, a.account_number, a.balance, a.user_seq, u.name
   from account a, users u
  where a.user_seq = u.user_seq;


--3. 고객번호 ( user_seq ) 가 111 인 고객의 계좌 중 잔고 ( balance ) 가 2000 이상 계좌 ( account ) 테이블을 조회하되, 
--고객번호, 고객명, 계좌번호, 잔고 순으로 조회한다.

select u.user_seq, u.name, a.account_number, a.balance
   from account a,
        users u
  where a.user_seq = u.user_seq
    and u.user_seq = 111 and a.balance >= 2000;


--4. 계좌 ( account ) 테이블의 잔고 ( balance ) 가 5000 이상인 고객의 고객번호 ( user_seq ), 고객명 ( name), 잔고 ( balance ) 를 
--조회한다. ( 단 Subquery 를 사용하지 않고 join 으로만 작성 )
select u.user_seq, u.name, a.balance
   from account a, users u
  where a.user_seq = u.user_seq and a.balance >= 5000;
  

--5. 위 4번 문제를 Subquery 를 이용해서 작성한다.
select u.user_seq, u.name, a.balance
   from ( select user_seq, balance from account where balance >= 5000 ) a,  users u
  where a.user_seq = u.user_seq;
  

--6. 고객 ( users ) 테이블에서 고객번호 ( user_seq ), 고객명 ( name) 조회하되, 
--고객명 뒤에 계좌의 수도 account_cnt 로 함께 조회한다. ( 단, 계좌가 없는 고객은 제외한다. )

select u.user_seq, u.name, a.account_cnt
  from users u, ( select user_seq, count(*) account_cnt from account where user_seq is not null group by user_seq  ) a
 where u.user_seq = a.user_seq;	   


--7. 위 6번 문제를 조회하되 계좌가 없는 고객도 함께 조회하고 계좌의 수에 0 으로 표시한다.
select u.user_seq, u.name, nvl(a.account_cnt, 0) account_cnt
  from users u left outer join ( select user_seq, count(*) account_cnt from account where user_seq is not null group by user_seq ) a
    on u.user_seq = a.user_seq;


--8. 각 계좌별 잔고 ( balance ) 가 전체 평균 잔고보다 적은 고객의 고객번호 ( user_seq ), 고객명 ( name) 을 조회한다.
-- 평균 잔고 4000
-- 4000 보다 작거나 같은 고객은 111, 222
-- 이는 고객별 전체 잔고와는 다르다.
select u.user_seq, u.name
  from users u
 where u.user_seq in ( select a.user_seq from account a where balance <= (select avg(balance) from account));  
 

--9. 고객의 잔고의 합이 전체 평균 잔고 + 5000 이하인 고객의 고객번호 ( user_seq ), 고객명 ( name) 을 조회한다.
select u.user_seq, u.name
  from users u
 where u.user_seq in (  
	 select user_seq
		from account
	   group by user_seq having sum(balance) <= (select avg(balance) + 5000 from account)
	   );

--10. 계좌 ( account ) 테이블에서 balance 기준 내림차순으로 정렬하되, 상위 5 건만 조회한다.
select aa.* from
( select a.*, rownum rnum from
    ( select * from account where balance is not null order by balance desc ) a
) aa    
where aa.rnum <= 5;

select * from employees;
select * from jobs;
select * from departments;

--11. salary 가 10000 이상인 사원의 employee_id, first_name, last_name, salary, job_title, department_name 을 조회한다.
select e.employee_id, e.first_name, e.last_name, e.salary, j.job_title, d.department_name
  from employees e, jobs j, departments d
 where e.job_id = j.job_id
   and e.department_id = d.department_id
   and e.salary >= 10000;
   
   
 --ansi조인방식  
 select employee_id, first_name, last_name, salary, job_title, department_name
  from employees  join jobs
 using(job_id) join departments
 using(department_id)
where salary >= 10000;

   

--12. job_id 가 IT_PROG 인 사원의 평균 salary 보다 salary 가 더 많은 사원의 총 수를 구한다.
select count(*) from employees where salary > (select avg(salary) from employees where job_id = 'IT_PROG');


--13. 입사일자가 '97/06/25' 이후 입사한 사원 중 부서의 최소 salary 가 8000 이상이고 
--부서의 최대 salary 가 20000 이하 인 부서에 해당하는 사원 전체를 조회한다.
select * from employees where hire_date > '97/06/25'
 and job_id in  ( select job_id from jobs where min_salary >= 8000 and max_salary <= 20000 );


--14. manager_id 가 108 인 department 소속 사원들의 평균 salary 를 구하여, department_id, department_avg_salary 로 조회한다.
 select department_id, avg(salary) department_avg_salary
  from (
		select department_id, salary 
		  from employees where department_id in 
		  (select department_id from departments where manager_id = 108 )
 )	
 group by department_id;	
 
 
 
 --1) manager_id가 108인 department_id 을 구한다.
        select department_id from departments where manager_id = 108;
        
 --2) 구한 department_id에 소속되어 있는 사원테이블에서  department_id, salary 를구한다.
      select department_id, salary 
		  from employees where department_id in 
		  (select department_id from departments where manager_id = 108 )
 
 --3)  2)의 결과를 인라인뷰를 이용해서 나온 사원들의 department_id별로 평균급여를 구한다.

 


--15. manager_id 가 없는 사원이 manager 로 등록되어 있는 사원의 employee_id, first_name, last_name, salary, job_title 조회한다.
 select e.employee_id, e.first_name, e.last_name, e.salary, j.job_title
  from employees e, jobs j
 where manager_id in (
	select employee_id
	  from employees
	 where manager_id is null
 )
 and e.job_Id = j.job_id;
 
 
  --1) manager_id가 null인 사원의 사원번호를 구한다.
     select employee_id from employees  where manager_id is null;
     
  --2) 1)에서 나온 employee_id를 manager_id로 갖고 있는 사원을 검색한다.
  
  --ansi변경
   select employee_id, first_name, last_name, salary, job_title , manager_id
  from employees e join jobs j
 using(job_id) where manager_id in (
	select employee_id
	  from employees
	 where manager_id is null
 );
 
 --인라인뷰 이용
 select employee_id,  first_name, last_name, salary, job_title , manager_id 
 from
 (select employee_id, job_id,first_name, last_name, salary, manager_id
 from employees where manager_id in (select employee_id from employees  where manager_id is null)) join jobs
 using(job_id);

 
 
 
 
 
 