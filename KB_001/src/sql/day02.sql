/*
   SELECT���� - DQL����
    : ����
    select distinct | * | �÷��� as ��Ī, �÷��� ��Ī,....   : ���� ���� :PROJECTION
    from ���̺��̸�     
    [where ���ǽ� ]  : ���ڵ�(Ʃ��)����  - SELECTION
    [order by �÷��� desc | asc , .. ] -����
    
    
    * distinct �� �ߺ����ڵ带 ����
    * AS �� �÷��� ��Ī ����� 
    * �������
      SELECT   3) 
      FROM     1)
      WHERE    2) 
      ORDER BY 4) 
    
*/

--EX) SCOTT���� ���� 

SELECT * FROM EMP; --������̺�
SELECT * FROM DEPT;--�μ��������̺�

--1) EMP���̺��� ���ϴ� �÷�(��Ī)
select empno, ename, hiredate �Ի���,  job, sal "�� ��"
from emp;

--2) �ߺ��� �����ϱ� - DISTINCT
 --EX) �츮ȸ�翡 � JOB�ִ��� JOB�� ������ �˰�ʹ�!!!
select distinct job
from emp;

select distinct deptno �μ���ȣ
from emp;
 
--3) ���� ����� 
 -- �޿��� 3000�̻��� ��� �˻�
select empno, ename, job, sal
from emp where sal >= 3000;
 
 --4) ����
 -- �޿��� 2000�̻��� ����� �˻��ϰ� �޿��� �������� ����
select empno, ename, job, sal
from emp where sal >= 2000
order by sal;
 
 

 --JOB�� �������� �������������ϰ� JOB�� ������ �޿��� �������� ����
select empno, ename, job, sal
from emp where sal >= 2000
order by job desc;


--��Ī�� �������� ����� �� ����
select empno, ename, job, sal
from emp where sal >= 2000
order by 3 desc; --index sort

-- �÷��鳢���� ���� ����
select empno, ename, sal, comm, sal + comm -- ������ �� null�� ������ ����� null��
from emp;

-- nvl() >> null ���� �ٸ� ������ �����ؼ� ���� ����
select comm, nvl(comm, 100) from emp;

select empno, ename, sal, comm, sal + nvl(comm, 0) �޿�, (sal + nvl(comm, 0)) * 12 ���� -- ������ �� null�� ������ ����� null��
from emp;



-----------------------------------------------------------------------------------
/*
  ������ ����
  1) ���������
     +, -, *, / 
     ������ : MOD(��, ������)
     
   2) ���迬����
       > , <, >= , <= , !=
       ����  :  =
       
   3) �񱳿�����
    - AND
    - OR
    - IN :  �÷��� IN (��, ��, ��)  - �ϳ��� �÷��� ������� �Ǵ����� ���Ҷ� ����Ѵ�.
    
    - BETWEEN AND :  �÷��� BETWEEN �ּ� AND �ִ� - �ϳ��� �÷��� ������� �ּ� ~ �ִ븦 ���Ҷ�
    
    - LIKE  : ���ϵ�ī�� ���ڿ� �Բ� ����Ѵ�.
        1. % : 0���̻��� ����
        2. _ : �ѱ���  
        
        EX)  name like 'J%' ;   - NAME�� ù���ڰ� J�� �����ϴ� ��� ����
             name like '___' ;  - NAME�� 3���� 
             name like 'J_J%';  - NAME�� ù���ڰ� J�� �����ϰ� 3��° ���� A�� ���� �˻�
             
    
    - NOT : ���� ��� �����ڵ� �տ� NOT�� ������ �ݴ� ����.
        
*/

--EX) SAL �� 2000 ~ 4000��� �˻�(AND, BETWEEN AND )
select * from emp
where sal between 2000 and 4000;
-- and �� �� ���� ������ �ٲ� �� ������ between�� �ٲ� �� ����


--EX) SAL �� 2000 ~ 4000����ƴ� ���ڵ� �˻� -  NOT
select * from emp
where not sal between 2000 and 4000
order by sal;


--EX) EMPNO �� 7566, 7782,7844�� ����˻� ( OR, IN)
select * from emp
where empno in (7566, 7782, 7844);




--EX) EMPNO �� 7566, 7782,7844�� ����� �ƴ� �˻� ( NOT)
select * from emp
where empno not in (7566, 7782, 7844);

---------------------------------------------------------------------------
--1) JOB�� 'A' ���ڷν����ϴ� ���ڵ� �˻�
select * from emp
where job like 'A%';


--2) JOB�� �� ���ڰ� 'N'���� ������ ���ڵ� �˻�
select * from emp
where job like '%N';


--3) ENAME�� 4������ ���ڵ� �˻�
select * from emp
where ename like '____';


--4) ENAME�� A���ڰ� ���Ե� ���ڵ� �˻�
select * from emp
where ename like '%A%';

select * from emp;

--5) ENAME��ü ���ڰ� 5�����̰� �ι�° ���ڰ� m�̸鼭�����ڰ� h�� ���ڵ� �˻�
select * from emp
where ename like '_M__H';

------------------------------------------------------------------

/*
null ã�� > is null, is not null
*/

select * from emp
where comm is null;

select * from emp
where comm is not null;


select * from emp;
update emp set comm = 100 where comm is null;

rollback;

select * from emp
order by comm asc; -- null�� �������� ��ȸ

select * from emp
order by comm asc nulls first;

select rownum, empno, ename from emp;

select rownum, e.* 
from emp e;

select rownum, e.* 
from emp e
order by comm desc; -- ������� issue >> subquery ���

select rownum, e.*
from (select * from emp order by comm desc nulls last) e
where rownum <= 2;

/*
any = some : �˻� ����� �ϳ� �̻� ��ġ�ϸ� �� (or ����)

all : �˻� ����� ��� ��ġ�ؾ߸� �� (and ����)
*/

select sal from emp where deptno = 30;

select * from emp
where sal >all(select sal from emp where deptno = 30);

