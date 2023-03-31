-----------------------------------------------------
--집계함수

CREATE TABLE REPORT(
 NAME VARCHAR2(20) CONSTRAINT REPORT_NAME_PK PRIMARY KEY,
 BAN CHAR(1),
 KOR NUMBER(3) CHECK(KOR BETWEEN 0 AND 100),
 ENG NUMBER(3) CHECK(ENG BETWEEN 0 AND 100),
 MATH NUMBER(3) CHECK(MATH BETWEEN 0 AND 100)
);

SELECT * FROM REPORT;

--샘플레코드
INSERT INTO REPORT VALUES('희정', 1 , 80, 70,90);
INSERT INTO REPORT VALUES('효리', 1 , 90, 50,90);

INSERT INTO REPORT VALUES('나영', 2 , 100, 65,85);
INSERT INTO REPORT VALUES('재석', 2 , 80, 70, 95);
INSERT INTO REPORT VALUES('희선', 2 , 85, 45,80);

INSERT INTO REPORT VALUES('승기', 3 , 50, 70,70);
INSERT INTO REPORT VALUES('중기', 3 , 90, 75,80);
INSERT INTO REPORT VALUES('혜교', 3 , 70, 90,95);
INSERT INTO REPORT VALUES('미나', 3 , NULL, 80,80);


-- 개인별 국어총점, 국어평균을 검색해보자.
select r.*, nvl(kor,0) + nvl(eng,0) + nvl(math,0) as 총점,
round((nvl(kor,0) + nvl(eng,0) + nvl(math,0) / 3), 1) 평점
from report r;

-- 국어점수의 최대, 최소, 전체학생수를 검색해보자.
select max(kor), min(kor), count(kor), count(*) --널포함
from report;

--수학점수 최대, 최소, 학생수 ( * | DISTINCT 사용해보자)
select max(math), min(math), count(distinct math)
from report;

select max(math), min(math), count(math)
from report;


--국어점수의 총점, 평균, NULL을 0으로 변경해서 평균 검색해보자 - AVG()함수는 NULL을 제외한 레코드수로 평균을 구한다. 
select sum(kor), avg(kor), round(avg(nvl(kor,0)),1) null처리한평균, count(kor)
from report;

select * from report;

--반별 국어 최대, 최소 총점 평균 인원수 - GROUP BY절에 나온 컬럼은 SELECT절에 집계함수와 함게 사용가능
select name, max(kor), min(kor), sum(kor)
from report; --분석함수를 별도로 사용해야 (집계함수를 일반컬럼과 함께 사용 불가)

select name, max(kor), min(kor), sum(kor)
from report
group by name;

-- KOR의 점수가 70이상인 학생들의 반별 국어 최대, 최소 총점 평균 인원수
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
where kor >= 70
group by ban;

-- KOR의 평균이 80 이상인 학생들의 반별 국어 최대, 최소 총점 평균 인원수 
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
where avg(kor) >= 80
group by ban; -- x
--having 사용
select ban, max(kor), min(kor), sum(kor), round(avg(kor),1), count(kor)
from report
group by ban
having avg(kor) >= 80;

select deptno, sum(sal)
from emp
group by deptno
having sum(sal) > 10000 and deptno in (20, 30); --되긴하지만 성능 저하

select deptno, sum(sal)
from emp
where deptno in (20, 30)
group by deptno
having sum(sal) > 10000; --결과는 같지만 이게 성능이 더 잘나옴

/*
  중요!!
 SELECT   5)
 FROM     1)
 WHERE    2)
 GROUP BY 3)
 HAVING   4)
 ORDER BY 6)

*/

-----------------------------------------------
SELECT BAN , SUM(KOR) 총점
FROM REPORT
WHERE KOR >=70
GROUP BY rollup(BAN); -- 소계 + 총계


SELECT BAN , SUM(KOR) 총점
FROM REPORT
WHERE KOR >=70
GROUP BY CUBE(BAN);

SELECT BAN , SUM(KOR) 총점
FROM REPORT
WHERE KOR >=70
GROUP BY GROUPING SETS(BAN);


---------------------------------------
/*
 ROLLUP VS CUBE VS GROUPING SETS
*/
CREATE TABLE MONTHLY_SALES( --월별매출
  GOODS_ID VARCHAR2(5), --상품아이디
  MONTH VARCHAR2(10), -- 월
  COMPANY VARCHAR2(20), --회사
  SALES_AMOUNT NUMBER -- 매출금액
);

INSERT INTO MONTHLY_SALES VALUES('P01','2023-01', '롯데', 15000);
INSERT INTO MONTHLY_SALES VALUES('P01','2023-02', '롯데', 25000);

INSERT INTO MONTHLY_SALES VALUES('P02','2023-01', '삼성', 8000);
INSERT INTO MONTHLY_SALES VALUES('P02','2023-02', '삼성', 12000);


INSERT INTO MONTHLY_SALES VALUES('P03','2023-01', 'LG', 8500);
INSERT INTO MONTHLY_SALES VALUES('P03','2023-02', 'LG', 13000);

SELECT * FROM MONTHLY_SALES;

SELECT GOODS_ID , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_ID); -- 총계 함께 출력 

SELECT MONTH , SUM(SALES_AMOUNT)
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH);


SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY ROLLUP(GOODS_iD,MONTH); -- ROLLUP 첫번째 나온 컬럼을 기준으로 소계, 전체 (인수의 순서가 중요)

SELECT MONTH , GOODS_iD  , SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY ROLLUP(MONTH , GOODS_iD);

--CUBE
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY CUBE(GOODS_iD,MONTH); -- CUBE 소계부분을 각 컬럼을 기준으로 나오기때문에서 인수의 순서가 상관없다. 

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY CUBE(MONTH , GOODS_ID);


--GROUPING SETS
SELECT GOODS_iD, MONTH , SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(GOODS_iD,MONTH);

SELECT  MONTH , GOODS_ID, SUM(SALES_AMOUNT) 총매출액
FROM MONTHLY_SALES
GROUP BY GROUPING SETS(MONTH ,GOODS_iD);

/*
  JOIN
   : 한번의 SELECT문장의로 2개 이상의 테이블에 있는 컬럼의 정보를 검색하고 싶을때 사용한다.
   : JOIN의 종류
     1) INNER JOIN
         - EQUI JOIN = 동등조인 = NATURAL JOIN
         - NON EQUI JOIN : 조인 대상 테이블의 어떤 컬럼의 값도 일치하지 않을때 사용
                          EX) BETWEEN AND , IS NULL, IS NOT NULL, IN, > , < 등의 이런 조건문을 사용할때 쓴다.
        
      2) OUTER JOIN
           : 기본 EQUI JOIN을 하면서 별도의 테이블의 모든 정보를 검색하고 싶을때.
              - LEFT OUTER JOIN
              - RIGHT OUTER JOIN
              - FULL OUTER JOIN
    
      3) SELF JOIN
           : 자기 자신테이블을 조인하는 것(하나의 테이블을 2개처럼 사용하는 것)
           : 주로 재귀적관계일 때 많이 사용한다. (재귀적관계란 자신자신테이블의 PK를 FK로 참조하는 것)
           
    : JOIN 코딩 방법
      1) SQL JOIN  - FULL OUTER JOIN은 제공하지 않는다. 
      2) ANSI JOIN : 미국국립표준연구소에서 정한 미국의 표준을 기본으로 한다. - 권장
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

select t1.id name, job, sal -- full outer 조인 방식에서는 지원 안함 >> ANSI 조인방식으로 해결
from test1 t1, test2 t2
where t1.id(+) = t2.id;

--ANSI
select *
from test1 t1 inner join test2 t2 --inner 생략 가능
on t1.id = t2.id;

select t1.id, name, job, sal
from test1 t1 join test2 t2
on t1.id = t2.id;

-- using절 사용  - 조인조건의 대상이 되는 컬럼의 이름이 동일할때는 on절 대신 using 사용
select id, name, job, sal
from test1 join test2
using(id);

--natural join - 조인을하는 테이블에서 같은 컬럼명, 같은 타입 갖는 컬럼 기준으로 모두 조인
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

--3개의 테이블 묶기
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

--join에 조건 넣기
select * from test1, test2, test3
where test1.id = test2.id and test2.code = test3.code and sal >= 300;

select *
from test1 join test2
using(id) join test3 using(code) where sal >= 300;



--------------------------------------------------------------
/*
  SET 집합
   1) 합집합
        UNION ALL - 중복레코드를포함
        UNION - 중복레코드 제외
        
   2) 교집합 
       INSERSECT : A와 B 테이블의 공통된 레코드 검색
       
   3) 차집합 
        MINUS : A테이블에서 B테이블이 레코드를 뺀 나머지 레코드 검색

 -------------------------------------------------------------
 /*
   SUBQUERY - 부질의
    : 메인쿼리안에 또 다른 쿼리가 존재하는것
    : ()괄호로 묶는다. 괄호안에 실행문장이 먼저 실행된후 그 결과를 메인쿼리의 조건으로 주로 사용한다. 
    : 서브쿼리의 결과 행이 한개 일때  비교연산자 사용.
    : 서브쿼리의 결과 행이 여러개 일때는 ANY, ALL, IN 연산자를 사용한다. 
    : 주로 SELECT에서 많이 사용하지만 CREATE, INSERT, UPDATE ,DELTE, 
           HAVING, WHERE , FROM ,ORDER 에서도 사용가능하다.
 */
 --EMP테이블에서 평균 급여보다 더 많이 받는 사원 검색
  select avg(sal) from emp;
  select * from emp
  where sal > (select avg(sal) from emp);
-- JOB에 'A'문자열이 들어간 사원의 부서와 같은 곳에서 근무하는 사원의 부서이름 검색하고 싶다. 
  select distinct deptno
  from emp where job like '%A%';
  
  select dname from dept
  where deptno in (select distinct deptno from emp where job like '%A%');
  --서브쿼리 결과 레코드 행이 여러개일 때, 등호는 쓸 수 없음 >> in any all 사용
  

 -- 부서번호가 30인 사원들이 급여중에서 가장 많이 받는 사원보다 더 많이 받는 사원정보를 검색하고 싶다. 
select sal from emp where deptno = 30;

select * from emp
where sal > all (select sal from emp where deptno = 30);


-- SUBQUERY를 INSERT
select * from emp;
create table copy as
select * from emp where 1=2;

select * from copy;
commit;

insert into copy (select * from emp where sal > 2000);

--특정 컬럼만 다른 테이블로부터 가져와서 insertㅎ ㅏ기
insert into copy(empno, ename, job, sal)(select empno, ename, job, sal from emp where deptno=20);


--SUBQUERY를 UPDATE
   --EX) EMP테이블에서 EMPNO 7900인 사원의 JOB, MGR, DEPTNO로 SUB_EMP테이블의 7566의 사원의 정보로 수정해보자.
update copy
set job = (select job from emp where empno = 7900), 
mgr = (select mgr from emp where empno = 7900), deptno = (select deptno from emp where empno = 7900)
where empno = 7566;
rollback;

update copy
set (job, mgr, deptno) = (select job, mgr, deptno from emp where empno = 7900)
where empno = 7566;

--SUBQUERY를 DELETE
   --EX) EMP테이블이 평균 급여를 조건으로 사용해서 평균급여보다 많이 받는 사원들을 삭제한다. 
delete
from copy
where sal < (select avg(sal) from emp);

select empno, ename, job, sal, deptno
from emp e
where sal > (select avg(sal) from emp where deptno = e.deptno)
order by deptno;

--------------------------------------------------------------
/*
  SUBQUERY 종류중의 하나인 인라인뷰
   : FROM절 뒤에 서브쿼리가 오는 것.
*/

-- 급여를 기준으로 정렬해서 ROWNUM을 함께 출력하고 싶다.
SELECT ROWNUM, EMPNO, ENAME, JOB, SAL 
FROM EMP 
ORDER BY SAL DESC; -- 정렬을 한 결과를 테이블처럼 사용하면서 ROWNUM 이용해야한다.

--1) 먼저 정렬한다.
SELECT * FROM EMP ORDER BY SAL DESC;

SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) ;--인라인뷰

-- ROWNUM을 대상으로 조건을 만들어보자 .
--1. ROWUM이 3보다 작은 레코드 검색
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM < 3;

--2. ROWUM이 3보다 큰 레코드 검색
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM > 3; --X

--3. ROWUM이 5 ~ 7 사이 레코드 검색
SELECT ROWNUM, ENAME, JOB, SAL
FROM (SELECT * FROM EMP ORDER BY SAL DESC) 
WHERE ROWNUM BETWEEN 5 AND 7 ; --X

/*
  ROWNUM은 레코드가 만들어지면서 번호가 순차적으로 부여되는 것을 ROWNUM 1 이 없으면 2를 실행할수 없다. 
  그래서 ROWNUM를 조건으로  ~ 크다  또는 중간범위를 직접 조건으로 사용할수없다.
  ROWNUM을 미리 다 부여된 결과를 조건으로 사용해야한다. 
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
  SEQUENCE : 자동 증가 값 설정
    :생성방법
      CREATE SEQUENCE 시퀀스이름
      [START WITH 초기값]
      [INCREMENT BY 증가값]
      [MAXVALUE 최댓값]
      [MINVALUE 최솟값]
      [CACHE | NOCACHE]
      [CYCLE | NOCYCLE]
      
    : 사용방법
      시퀀스이름.NEXTVAL : 시퀀스를 증가
      시퀀스이름.CURRVAL : 시퀀스의 현재값 가져오기
       
    : 시퀀스 수정
    ALTER SEQUENCE 시퀀스이름;
    
    : 시퀀스 삭제
    DROP SEQUENCE 시퀀스이름;
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

