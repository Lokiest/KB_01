-----------------------------------------------------
--�����Լ�

CREATE TABLE REPORT(
 NAME VARCHAR2(20) CONSTRAINT REPORT_NAME_PK PRIMARY KEY,
 BAN CHAR(1),
 KOR NUMBER(3) CHECK(KOR BETWEEN 0 AND 100),
 ENG NUMBER(3) CHECK(ENG BETWEEN 0 AND 100),
 MATH NUMBER(3) CHECK(MATH BETWEEN 0 AND 100)
);

SELECT * FROM REPORT;

--���÷��ڵ�
INSERT INTO REPORT VALUES('����', 1 , 80, 70,90);
INSERT INTO REPORT VALUES('ȿ��', 1 , 90, 50,90);

INSERT INTO REPORT VALUES('����', 2 , 100, 65,85);
INSERT INTO REPORT VALUES('�缮', 2 , 80, 70, 95);
INSERT INTO REPORT VALUES('��', 2 , 85, 45,80);

INSERT INTO REPORT VALUES('�±�', 3 , 50, 70,70);
INSERT INTO REPORT VALUES('�߱�', 3 , 90, 75,80);
INSERT INTO REPORT VALUES('����', 3 , 70, 90,95);
INSERT INTO REPORT VALUES('�̳�', 3 , NULL, 80,80);


-- ���κ� ��������, ��������� �˻��غ���.
select r.*, nvl(kor,0) + nvl(eng,0) + nvl(math,0) as ����,
round((nvl(kor,0) + nvl(eng,0) + nvl(math,0) / 3), 1) ����
from report r;

-- ���������� �ִ�, �ּ�, ��ü�л����� �˻��غ���.
select max(kor), min(kor), count(kor), count(*) --������
from report;

--�������� �ִ�, �ּ�, �л��� ( * | DISTINCT ����غ���)
select max(math), min(math), count(distinct math)
from report;

select max(math), min(math), count(math)
from report;


--���������� ����, ���, NULL�� 0���� �����ؼ� ��� �˻��غ��� - AVG()�Լ��� NULL�� ������ ���ڵ���� ����� ���Ѵ�. 
select sum(kor), avg(kor), round(avg(nvl(kor,0)),1) nulló�������, count(kor)
from report;

select * from report;

--�ݺ� ���� �ִ�, �ּ� ���� ��� �ο��� - GROUP BY���� ���� �÷��� SELECT���� �����Լ��� �԰� ��밡��
select name, max(kor), min(kor), sum(kor)
from report; --�м��Լ��� ������ ����ؾ� (�����Լ��� �Ϲ��÷��� �Բ� ��� �Ұ�)

select name, max(kor), min(kor), sum(kor)
from report
group by name;

-- KOR�� ������ 70�̻��� �л����� �ݺ� ���� �ִ�, �ּ� ���� ��� �ο���
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
where kor >= 70
group by ban;

-- KOR�� ����� 80 �̻��� �л����� �ݺ� ���� �ִ�, �ּ� ���� ��� �ο��� 
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
where avg(kor) >= 80
group by ban; -- x
--having ���
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
group by ban
having avg(kor) >= 80;

select deptno, sum(sal)
from emp
group by deptno
having sum(sal) > 10000 and deptno in (20, 30); --�Ǳ������� ���� ����

select deptno, sum(sal)
from emp
where deptno in (20, 30)
group by deptno
having sum(sal) > 10000; --����� ������ �̰� ������ �� �߳���

/*
  �߿�!!
 SELECT   5)
 FROM     1)
 WHERE    2)
 GROUP BY 3)
 HAVING   4)
 ORDER BY 6)

*/

-----------------------------------------------
SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY rollup(BAN); -- �Ұ� + �Ѱ�


SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY CUBE(BAN);

SELECT BAN , SUM(KOR) ����
FROM REPORT
WHERE KOR >=70
GROUP BY GROUPING SETS(BAN);


---------------------------------------
/*
 ROLLUP VS CUBE VS GROUPING SETS
*/
CREATE TABLE MONTHLY_SALES( --��������
  GOODS_ID VARCHAR2(5), --��ǰ���̵�
  MONTH VARCHAR2(10), -- ��
  COMPANY VARCHAR2(20), --ȸ��
  SALES_AMOUNT NUMBER -- ����ݾ�
);

INSERT INTO MONTHLY_SALES VALUES('P01','2023-01', '�Ե�', 15000);
INSERT INTO MONTHLY_SALES VALUES('P01','2023-02', '�Ե�', 25000);

INSERT INTO MONTHLY_SALES VALUES('P02','2023-01', '�Ｚ', 8000);
INSERT INTO MONTHLY_SALES VALUES('P02','2023-02', '�Ｚ', 12000);


INSERT INTO MONTHLY_SALES VALUES('P03','2023-01', 'LG', 8500);
INSERT INTO MONTHLY_SALES VALUES('P03','2023-02', 'LG', 13000);

SELECT * FROM MONTHLY_SALES;

SELECT GOODS_ID , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_ID); -- �Ѱ� �Բ� ��� 

SELECT MONTH , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH);


SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_iD,MONTH); -- ROLLUP ù��° ���� �÷��� �������� �Ұ�, ��ü (�μ��� ������ �߿�)

SELECT MONTH , GOODS_iD  , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH , GOODS_iD);

--CUBE
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY CUBE(GOODS_iD,MONTH); -- CUBE �Ұ�κ��� �� �÷��� �������� �����⶧������ �μ��� ������ �������. 

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY CUBE(MONTH , GOODS_ID);


--GROUPING SETS
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(GOODS_iD,MONTH);

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) �Ѹ����
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(MONTH ,GOODS_iD);

/*
  JOIN
   : �ѹ��� SELECT�����Ƿ� 2�� �̻��� ���̺� �ִ� �÷��� ������ �˻��ϰ� ������ ����Ѵ�.
   : JOIN�� ����
     1) INNER JOIN
         - EQUI JOIN = �������� = NATURAL JOIN
         - NON EQUI JOIN : ���� ��� ���̺��� � �÷��� ���� ��ġ���� ������ ���
                          EX) BETWEEN AND , IS NULL, IS NOT NULL, IN, > , < ���� �̷� ���ǹ��� ����Ҷ� ����.
        
      2) OUTER JOIN
           : �⺻ EQUI JOIN�� �ϸ鼭 ������ ���̺��� ��� ������ �˻��ϰ� ������.
              - LEFT OUTER JOIN
              - RIGHT OUTER JOIN
              - FULL OUTER JOIN
    
      3) SELF JOIN
           : �ڱ� �ڽ����̺��� �����ϴ� ��(�ϳ��� ���̺��� 2��ó�� ����ϴ� ��)
           : �ַ� ����������� �� ���� ����Ѵ�. (���������� �ڽ��ڽ����̺��� PK�� FK�� �����ϴ� ��)
           
    : JOIN �ڵ� ���
      1) SQL JOIN  - FULL OUTER JOIN�� �������� �ʴ´�. 
      2) ANSI JOIN : �̱�����ǥ�ؿ����ҿ��� ���� �̱��� ǥ���� �⺻���� �Ѵ�. - ����
*/
create table test1 (
    id varchar2(10) primary key,
    name varchar2(30),
    addr varchar2(50)
);
insert into test1 values('park', 'juho', 'seoul');
insert into test1 values('kim', 'dohyun', 'LA');
insert into test1 values('lee', 'harry', 'SanFran');
insert into test1 values('jang', 'potter', 'London');
insert into test1 values('choi', 'thor', 'Paris');
select * from test1;

create table test2 (
    code char(3) primary key,
    id varchar2(10) references test1(id),
    job varchar2(30),
    sal number(3)
);

select * from test2;

insert into test2 values('A01', 'park', 'manager', 500);
insert into test2 values('A02', 'park', 'developerr', 600);
insert into test2 values('A03', 'kim', 'Singer', 800);
insert into test2 values('A04', 'lee', 'dancer', 300);
insert into test2 values('A05', null, 'backend', 200);

select *from test1;
select * from test2;

select t1.id name, job, sal
from test1 t1, test2 t2
where t1.id = t2.id(+);

select t1.id name, job, sal -- full outer ���� ��Ŀ����� ���� ���� >> ANSI ���ι������ �ذ�
from test1 t1, test2 t2
where t1.id(+) = t2.id;

--ANSI
select *
from test1 t1 inner join test2 t2 --inner ���� ����
on t1.id = t2.id;

select t1.id, name, job, sal
from test1 t1 join test2 t2
on t1.id = t2.id;

-- using�� ���  - ���������� ����� �Ǵ� �÷��� �̸��� �����Ҷ��� on�� ��� using ���
select id, name, job, sal
from test1 join test2
using(id);

--natural join - �������ϴ� ���̺��� ���� �÷���, ���� Ÿ�� ���� �÷� �������� ��� ����
select *
from test1 natural join test2;

--outer join
select *
from test1 t1 left join test2 t2
using(id);

select *
from test1 t1 right join test2 t2
using(id);

select *
from test1 t1 full join test2 t2
using(id);

--3���� ���̺� ����
create table test3 (
    code char(3) primary key references test2(code),
    manager_name varchar2(30),
    phone varchar2(30)
);

insert into test3 values('A04','A','111-1111');
insert into test3 values('A02','B','222-2222');
insert into test3 values('A03','C','333-3333');

select * from test1;
select * from test2;
select * from test3;

-- SQL join
select * from test1, test2, test3
where test1.id = test2.id and test2.code = test3.code;

--ANSI
select *
from test1 join test2
using(id) join test3 using(code);

--join�� ���� �ֱ�
select * from test1, test2, test3
where test1.id = test2.id and test2.code = test3.code and sal >= 300;

select *
from test1 join test2
using(id) join test3 using(code) where sal >= 300;



--------------------------------------------------------------
/*
  SET ����
   1) ������
        UNION ALL - �ߺ����ڵ带����
        UNION - �ߺ����ڵ� ����
        
   2) ������ 
       INSERSECT : A�� B ���̺��� ����� ���ڵ� �˻�
       
   3) ������ 
        MINUS : A���̺��� B���̺��� ���ڵ带 �� ������ ���ڵ� �˻�

 -------------------------------------------------------------
 /*
   SUBQUERY - ������
    : ���������ȿ� �� �ٸ� ������ �����ϴ°�
    : ()��ȣ�� ���´�. ��ȣ�ȿ� ���๮���� ���� ������� �� ����� ���������� �������� �ַ� ����Ѵ�. 
    : ���������� ��� ���� �Ѱ� �϶�  �񱳿����� ���.
    : ���������� ��� ���� ������ �϶��� ANY, ALL, IN �����ڸ� ����Ѵ�. 
    : �ַ� SELECT���� ���� ��������� CREATE, INSERT, UPDATE ,DELTE, 
           HAVING, WHERE , FROM ,ORDER ������ ��밡���ϴ�.
 */
 --EMP���̺��� ��� �޿����� �� ���� �޴� ��� �˻�
  select avg(sal) from emp;
  select * from emp
  where sal > (select avg(sal) from emp);
-- JOB�� 'A'���ڿ��� �� ����� �μ��� ���� ������ �ٹ��ϴ� ����� �μ��̸� �˻��ϰ� �ʹ�. 
  select distinct deptno
  from emp where job like '%A%';
  
  select dname from dept
  where deptno in (select distinct deptno from emp where job like '%A%');
  --�������� ��� ���ڵ� ���� �������� ��, ��ȣ�� �� �� ���� >> in any all ���
  

 -- �μ���ȣ�� 30�� ������� �޿��߿��� ���� ���� �޴� ������� �� ���� �޴� ��������� �˻��ϰ� �ʹ�. 
select sal from emp where deptno = 30;

select * from emp
where sal > all (select sal from emp where deptno = 30);


-- SUBQUERY�� INSERT
select * from emp;
create table copy as
select * from emp where 1=2;

select * from copy;
commit;

insert into copy (select * from emp where sal > 2000);

--Ư�� �÷��� �ٸ� ���̺�κ��� �����ͼ� insert�� ����
insert into copy(empno, ename, job, sal)(select empno, ename, job, sal from emp where deptno=20);


--SUBQUERY�� UPDATE
   --EX) EMP���̺��� EMPNO 7900�� ����� JOB, MGR, DEPTNO�� SUB_EMP���̺��� 7566�� ����� ������ �����غ���.
update copy
set job = (select job from emp where empno = 7900), 
mgr = (select mgr from emp where empno = 7900), deptno = (select deptno from emp where empno = 7900)
where empno = 7566;
rollback;

update copy
set (job, mgr, deptno) = (select job, mgr, deptno from emp where empno = 7900)
where empno = 7566;

--SUBQUERY�� DELETE
   --EX) EMP���̺��� ��� �޿��� �������� ����ؼ� ��ձ޿����� ���� �޴� ������� �����Ѵ�. 
delete
from copy
where sal < (select avg(sal) from emp);

select empno, ename, job, sal, deptno
from emp e
where sal > (select avg(sal) from emp where deptno = e.deptno)
order by deptno;

--------------------------------------------------------------
/*
  SUBQUERY �������� �ϳ��� �ζ��κ�
   : FROM�� �ڿ� ���������� ���� ��.
*/

-- �޿��� �������� �����ؼ� ROWNUM�� �Բ� ����ϰ� �ʹ�.
SELECT ROWNUM, EMPNO, ENAME, JOB, SAL 
FROM EMP 
ORDER BY SAL DESC; -- ������ �� ����� ���̺�ó�� ����ϸ鼭 ROWNUM �̿��ؾ��Ѵ�.

--1) ���� �����Ѵ�.
SELECT * FROM EMP ORDER BY SAL DESC;

SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) ;--�ζ��κ�

-- ROWNUM�� ������� ������ ������ .
--1. ROWUM�� 3���� ���� ���ڵ� �˻�
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM < 3;

--2. ROWUM�� 3���� ū ���ڵ� �˻�
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM > 3; --X

--3. ROWUM�� 5 ~ 7 ���� ���ڵ� �˻�
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM BETWEEN 5 AND 7 ; --X

/*
  ROWNUM�� ���ڵ尡 ��������鼭 ��ȣ�� ���������� �ο��Ǵ� ���� ROWNUM 1 �� ������ 2�� �����Ҽ� ����. 
  �׷��� ROWNUM�� ��������  ~ ũ��  �Ǵ� �߰������� ���� �������� ����Ҽ�����.
  ROWNUM�� �̸� �� �ο��� ����� �������� ����ؾ��Ѵ�. 
*/
SELECT * FROM 
    (SELECT ROWNUM NO, ENAME, JOB, SAL
    FROM (SELECT * FROM EMP ORDER BY SAL DESC) )
WHERE NO >3 ; 

SELECT * FROM 
    (SELECT ROWNUM NO, ENAME, JOB, SAL
    FROM (SELECT * FROM EMP ORDER BY SAL DESC) )
WHERE NO BETWEEN 5 AND 7 ;




----------------------------------------------------------
/*
  SEQUENCE : �ڵ� ���� �� ����
    :�������
      CREATE SEQUENCE �������̸�
      [START WITH �ʱⰪ]
      [INCREMENT BY ������]
      [MAXVALUE �ִ�]
      [MINVALUE �ּڰ�]
      [CACHE | NOCACHE]
      [CYCLE | NOCYCLE]
      
    : �����
      �������̸�.NEXTVAL : �������� ����
      �������̸�.CURRVAL : �������� ���簪 ��������
       
    : ������ ����
    ALTER SEQUENCE �������̸�;
    
    : ������ ����
    DROP SEQUENCE �������̸�;
*/
select * from board;

create table board(
    bno number primary key,
    subject varchar(20),
    reg_date date default sysdate
);

create sequence board_bno_seq;

select board_bno_seq.nextval, board_bno_seq.currval from dual;

drop sequence board_bno_seq;

insert into board(bno, subject) values(board_bno_seq.nextval, 'title');

