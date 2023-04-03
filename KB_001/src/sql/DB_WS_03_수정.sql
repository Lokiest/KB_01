
--1. ���� ( account ) ���̺��� ��ȸ�ϵ�, ���� ( name) �� �Բ� ��ȸ�Ѵ�.

 select account.account_seq, account.account_number, account.balance, account.user_seq, users.name
   from account join users
   on account.user_seq = users.user_seq;


--2. �� 1�� query �� table alias �� ����ϰ�, ANSI JOIN ��� ����Ŭ Join ǥ����� ����Ѵ�.

 select a.account_seq, a.account_number, a.balance, a.user_seq, u.name
   from account a, users u
  where a.user_seq = u.user_seq;


--3. ����ȣ ( user_seq ) �� 111 �� ���� ���� �� �ܰ� ( balance ) �� 2000 �̻� ���� ( account ) ���̺��� ��ȸ�ϵ�, 
--����ȣ, ����, ���¹�ȣ, �ܰ� ������ ��ȸ�Ѵ�.

select u.user_seq, u.name, a.account_number, a.balance
   from account a,
        users u
  where a.user_seq = u.user_seq
    and u.user_seq = 111 and a.balance >= 2000;


--4. ���� ( account ) ���̺��� �ܰ� ( balance ) �� 5000 �̻��� ���� ����ȣ ( user_seq ), ���� ( name), �ܰ� ( balance ) �� 
--��ȸ�Ѵ�. ( �� Subquery �� ������� �ʰ� join ���θ� �ۼ� )
select u.user_seq, u.name, a.balance
   from account a, users u
  where a.user_seq = u.user_seq and a.balance >= 5000;
  

--5. �� 4�� ������ Subquery �� �̿��ؼ� �ۼ��Ѵ�.
select u.user_seq, u.name, a.balance
   from ( select user_seq, balance from account where balance >= 5000 ) a,  users u
  where a.user_seq = u.user_seq;
  

--6. �� ( users ) ���̺��� ����ȣ ( user_seq ), ���� ( name) ��ȸ�ϵ�, 
--���� �ڿ� ������ ���� account_cnt �� �Բ� ��ȸ�Ѵ�. ( ��, ���°� ���� ���� �����Ѵ�. )

select u.user_seq, u.name, a.account_cnt
  from users u, ( select user_seq, count(*) account_cnt from account where user_seq is not null group by user_seq  ) a
 where u.user_seq = a.user_seq;	   


--7. �� 6�� ������ ��ȸ�ϵ� ���°� ���� ���� �Բ� ��ȸ�ϰ� ������ ���� 0 ���� ǥ���Ѵ�.
select u.user_seq, u.name, nvl(a.account_cnt, 0) account_cnt
  from users u left outer join ( select user_seq, count(*) account_cnt from account where user_seq is not null group by user_seq ) a
    on u.user_seq = a.user_seq;


--8. �� ���º� �ܰ� ( balance ) �� ��ü ��� �ܰ��� ���� ���� ����ȣ ( user_seq ), ���� ( name) �� ��ȸ�Ѵ�.
-- ��� �ܰ� 4000
-- 4000 ���� �۰ų� ���� ���� 111, 222
-- �̴� ���� ��ü �ܰ�ʹ� �ٸ���.
select u.user_seq, u.name
  from users u
 where u.user_seq in ( select a.user_seq from account a where balance <= (select avg(balance) from account));  
 

--9. ���� �ܰ��� ���� ��ü ��� �ܰ� + 5000 ������ ���� ����ȣ ( user_seq ), ���� ( name) �� ��ȸ�Ѵ�.
select u.user_seq, u.name
  from users u
 where u.user_seq in (  
	 select user_seq
		from account
	   group by user_seq having sum(balance) <= (select avg(balance) + 5000 from account)
	   );

--10. ���� ( account ) ���̺��� balance ���� ������������ �����ϵ�, ���� 5 �Ǹ� ��ȸ�Ѵ�.
select aa.* from
( select a.*, rownum rnum from
    ( select * from account where balance is not null order by balance desc ) a
) aa    
where aa.rnum <= 5;

select * from employees;
select * from jobs;
select * from departments;

--11. salary �� 10000 �̻��� ����� employee_id, first_name, last_name, salary, job_title, department_name �� ��ȸ�Ѵ�.
select e.employee_id, e.first_name, e.last_name, e.salary, j.job_title, d.department_name
  from employees e, jobs j, departments d
 where e.job_id = j.job_id
   and e.department_id = d.department_id
   and e.salary >= 10000;
   
   
 --ansi���ι��  
 select employee_id, first_name, last_name, salary, job_title, department_name
  from employees  join jobs
 using(job_id) join departments
 using(department_id)
where salary >= 10000;

   

--12. job_id �� IT_PROG �� ����� ��� salary ���� salary �� �� ���� ����� �� ���� ���Ѵ�.
select count(*) from employees where salary > (select avg(salary) from employees where job_id = 'IT_PROG');


--13. �Ի����ڰ� '97/06/25' ���� �Ի��� ��� �� �μ��� �ּ� salary �� 8000 �̻��̰� 
--�μ��� �ִ� salary �� 20000 ���� �� �μ��� �ش��ϴ� ��� ��ü�� ��ȸ�Ѵ�.
select * from employees where hire_date > '97/06/25'
 and job_id in  ( select job_id from jobs where min_salary >= 8000 and max_salary <= 20000 );


--14. manager_id �� 108 �� department �Ҽ� ������� ��� salary �� ���Ͽ�, department_id, department_avg_salary �� ��ȸ�Ѵ�.
 select department_id, avg(salary) department_avg_salary
  from (
		select department_id, salary 
		  from employees where department_id in 
		  (select department_id from departments where manager_id = 108 )
 )	
 group by department_id;	
 
 
 
 --1) manager_id�� 108�� department_id �� ���Ѵ�.
        select department_id from departments where manager_id = 108;
        
 --2) ���� department_id�� �ҼӵǾ� �ִ� ������̺���  department_id, salary �����Ѵ�.
      select department_id, salary 
		  from employees where department_id in 
		  (select department_id from departments where manager_id = 108 )
 
 --3)  2)�� ����� �ζ��κ並 �̿��ؼ� ���� ������� department_id���� ��ձ޿��� ���Ѵ�.

 


--15. manager_id �� ���� ����� manager �� ��ϵǾ� �ִ� ����� employee_id, first_name, last_name, salary, job_title ��ȸ�Ѵ�.
 select e.employee_id, e.first_name, e.last_name, e.salary, j.job_title
  from employees e, jobs j
 where manager_id in (
	select employee_id
	  from employees
	 where manager_id is null
 )
 and e.job_Id = j.job_id;
 
 
  --1) manager_id�� null�� ����� �����ȣ�� ���Ѵ�.
     select employee_id from employees  where manager_id is null;
     
  --2) 1)���� ���� employee_id�� manager_id�� ���� �ִ� ����� �˻��Ѵ�.
  
  --ansi����
   select employee_id, first_name, last_name, salary, job_title , manager_id
  from employees e join jobs j
 using(job_id) where manager_id in (
	select employee_id
	  from employees
	 where manager_id is null
 );
 
 --�ζ��κ� �̿�
 select employee_id,  first_name, last_name, salary, job_title , manager_id 
 from
 (select employee_id, job_id,first_name, last_name, salary, manager_id
 from employees where manager_id in (select employee_id from employees  where manager_id is null)) join jobs
 using(job_id);

 
 
 
 
 
 