select * from emp;
/* emp_id - �����ȣ, emp_name - ����̸�, job - ������, dept_id - �μ���ȣ
   sal ,- �޿�, bonus - ���ʽ�,  mgr_id - �����ڹ�ȣ , hiredate - �Ի���*/


--1. emp ���̺��� �� ��� emp_name�� �޿�(sal)�� 100�� ���� �� 12�� ���� ���� ��µǵ���  select���� ������� ����غ�����.(��Ī- ��� )
  select emp_name, (sal+100)*12 as ��� 
  from emp;
  
--2.������ job�� �������� ��� ����� �̸�(emp_name), ������(job),�μ���ȣ(dept_id)�� �˻��� ������.
  select emp_name,job,dept_id 
  from emp 
  where job='������';
  
--3.�Ի���(hiredate)�� ��2001��12��3�ϡ��� ��� ����� �˻� �ϼ���.

select * from emp where hiredate='2001��12��3��'; --���x

select * from emp where hiredate='2001-12-3'; --OK
select * from emp where hiredate='2001-12-03'; --ok

select hiredate, to_char(hiredate, 'YYYY') ||'��' || to_char(hiredate, 'MM')
from emp;

select * from emp 
  where 
  to_char(hiredate,'yyyy')||'��'|| 
  to_char(hiredate,'MM')||'��' || 
  to_char(hiredate,'DD')||'��' = '2001��12��03��';
  
  
  
  select * from emp where to_char(hiredate,'yyyy-mm-dd')='2001-12-03'; --0k
  select * from emp where to_char(hiredate,'yyyy-mm-dd')='2001-12-3'; --x
  
 select HIREDATE, TO_CHAR(HIREDATE,'YYYY"��"MM"��"DD"��"') from emp ;
 
 SELECT  * FROM EMP
  WHERE TO_CHAR(HIREDATE,'YYYY"��"MM"��"DD"��"')='2001��12��03��';
    
  select  hiredate , to_char(hiredate,'yyyy-mm-dd HH:MI:SS') from emp ;

  
  --4.�μ���ȣ(dept_id)�� 200�� �μ����� �ٹ��ϴ� ��� ����� �̸��� ������,�Ի���,�μ���ȣ�˻��ϼ���.
  select emp_name,job,hiredate,dept_id 
  from emp 
  where dept_id=200;
  
--5.emp���̺��� �޿��� 3000�̻� 5000������ ��� ����� �̸��� �޿��� ����ϼ���.
  select emp_name , sal 
  from emp 
  where sal between 3000 and 5000;
  
--6.emp���̺��� �����ڹ�ȣ(mgr_id)�� 6311,6361,6351��� �ϳ��� ��� ����� �����ȣ,�����ڹ�ȣ,�̸�,�μ���ȣ�� ����ϼ���.
  select emp_id,mgr_id,emp_name,dept_id 
  from emp
  where mgr_id in (6311,6361,6351);
  
   select emp_id,mgr_id,emp_name,dept_id 
  from emp
  where mgr_id = any (6311,6361,6351);
  
   
--7.�������� �繫���̰ų� �渮�� ����� ��� ������ �˻��ϼ���.
  select * from emp where job='�繫��' or job='�渮';
  select * from emp where job in('�繫��','�渮');
 select * from emp where job = any ('�繫��','�渮');
 

--8.emp���̺��� �޿��� 3000�̻��� ��� ������ ������ �˻��ϼ���.
  select * from emp 
  where  sal>=3000 and job='����';
  
 --9. emp���̺��� �������� ������ , �繫���� �ƴ� ��� ����� ������ �˻��ϼ���.
  select * from emp where job not in('������','�繫��');
  select * from emp where not job in('������','�繫��');
  select * from emp where  (job !='������' and job!='�繫��');
  
--10. emp���̺��� �޿��� 1500�̻� 2500���ϰ�  �ƴ� ��� ����� ������ �˻��ϼ���.
  select * 
  from emp 
  where sal not between 1500 and 2500;
  
--11.�������� �渮�̰ų� �����̸鼭 �޿��� 3000�� �Ѵ� ��� ����� ������ �˻��ϰ� ������� �Ի��� ������� ����ϼ���.
  select * from emp 
  where job in('�渮','����') and sal >=3000 
  order by hiredate ;
 
--12.����� �μ���ȣ�� �������� ������������ �����ϵ�, ���� �μ� �ȿ����� �޿��� ���� ����� ���� ��� �ǵ��� �ϼ���.
  select * from emp 
  order by dept_id , sal desc;

--13.���ʽ�(bonus)�� null�� �ƴϸ鼭 �Ի����� 2000�� �̻��� ����� ������ �˻��ϼ���.
  select * from emp 
  where bonus is not null and hiredate >= '2000-1-1';
   
  select * from emp 
  where bonus is not null and to_char(hiredate,'yyyy') >= '2000';

--14.emp_name�� 3�����̰� �� ���ڰ� ����'�̸� ù���ڴ� ���ڡ����� �����ϴ� ����� �����˻��ϼ���.
  select * from emp where emp_name like '��_��';
  

--15. ���ʽ�(bonus)�� null�� ����� ���ʽ��� 0���� �����ϼ���.
  select bonus, nvl(bonus,0) from emp;
  commit; 
  select * from emp;
  
  update emp 
  set bonus = nvl(bonus,0) ;
  
  rollback

  update emp 
  set bonus=0 
  where bonus is null ;
  

--16. ������ �����������鼭 �޿��� 2000~3000���� �� ����� �̸��� ���嵿�ǡ�, �޿��� 3500���� �����ϼ���.
  update emp 
  set emp_name='�嵿��', sal=3500 
  where job like '%��' and sal between 2000 and 3000;
  

--17. emp_name�� ��ö���ڰ� ���鼭 ������ ������ ����� ������ �����ϼ���.
  delete from emp 
  where emp_name like '%ö%' and job='����';

  delete  emp 
  where emp_name like '%ö%' and job='����';
  
  
--18.���̺��� �����ϼ���. 
  drop table emp; --
  
  --DDL : CREATE ,ALTER ,DROP  --ROLLBACK�ȵ�
  --DML : INSERT ,UPDATE ,DELETE - ROLLBACK����
  
  
  
  