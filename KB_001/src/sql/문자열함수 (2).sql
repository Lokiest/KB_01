/*
���ڿ� �Լ�
*/

select ename, upper(ename), lower(ename), initcap(ename) from emp;

select job, substr(job, 1, 3), substr(job,2,3), substr(job,3) from emp;

select 'ABCDE ABCDE ABCDE ABCDE', instr('ABCDE ABCDE ABCDE ABCDE', 'C'),
           instr('ABCDE ABCDE ABCDE ABCDE', 'C', 5) from dual;

select 231.132123, round(231.132123,2), trunc(231.132123,2), ceil(231.132123), floor(231.132123) from dual;

select sal, mod(sal,12) rest
from emp;

-- date function
select empno, hiredate, sysdate - hiredate, hiredate + 5, to_char(hiredate + 5 / 24, 'YYYY-MM-DD HH:MI:SS')
from emp;

select sysdate, extract(day from sysdate) from dual;
select sysdate, to_char(sysdate, 'yy') from dual;

/*
 ������ Ÿ�� ��ȯ to_char, to_date, to_number
*/


select ename, comm, sal, coalesce(comm, sal, 50) result
from emp;

/*
 EX) EMP���̺��� DEPNO�� 10 �̸� ������, 20�̸� �ѹ���, 30�̸� ������ 
     �̿��� ���� ��Ÿ�� �� ����ϰ� �÷����� �μ��� ���� �Ѵ�.
     (DECODE, CASE END)

ex)job�� manager�� ��� sal*0.1, ANALYST �ΰ���   sal *0.2
     SALESMAN�� ���� sal * 0.3�� ���ؼ� ������ �ʵ带 �����.
      (case end, decode �� �غ���) 


ex) sal�� 2000�����̸� '���ҵ���'
      sal�� 2001 ~ 4000���̸� '�߻���'
      sal�� 4001 �̻��̸� '��ҵ���'  ���Ͽ� ��� ��Ī ���ش�.
      (case end) 
*/

select empno, ename, job, deptno, decode(deptno, 10, '������', 20, '�ѹ���', 30,'������','��Ÿ��') �μ���
from emp;

select empno, ename, job, deptno,
case deptno when 10 then '������' when 20 then '�ѹ���' when 30 then '������' end �μ��� from emp;

select e.*,
case job when 'MANAGER' then sal* 0.1 when 'ANALYST' then sal * 0.2 when 'SALESMAN' then sal * 0.3 end ������
from emp e;

select e.*,
case when sal <= 2000 then '��' when sal between 2001 and 4000 then '��' when sal >=4001 then '��' end ���
from emp e;
