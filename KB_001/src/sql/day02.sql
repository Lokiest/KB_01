/*
   SELECT문장 - DQL문장
    : 구조
    select distinct | * | 컬럼명 as 별칭, 컬럼명 별칭,....   : 열을 제한 :PROJECTION
    from 테이블이름     
    [where 조건식 ]  : 레코드(튜플)제한  - SELECTION
    [order by 컬럼명 desc | asc , .. ] -정렬
    
    
    * distinct 는 중복레코드를 제거
    * AS 는 컬럼에 별칭 만들기 
    * 실행순서
      SELECT   3) 
      FROM     1)
      WHERE    2) 
      ORDER BY 4) 
    
*/

--EX) SCOTT계정 접속 

SELECT * FROM EMP; --사원테이블
SELECT * FROM DEPT;--부서정보테이블

--1) EMP테이블에서 원하는 컬럼(별칭)
select empno, ename, hiredate 입사일,  job, sal "년 봉"
from emp;

--2) 중복행 제거하기 - DISTINCT
 --EX) 우리회사에 어떤 JOB있는지 JOB의 종류를 알고싶다!!!
select distinct job
from emp;

select distinct deptno 부서번호
from emp;
 
--3) 조건 만들기 
 -- 급여가 3000이상인 사원 검색
select empno, ename, job, sal
from emp where sal >= 3000;
 
 --4) 정렬
 -- 급여가 2000이상인 사원을 검색하고 급여를 기준으로 정렬
select empno, ename, job, sal
from emp where sal >= 2000
order by sal;
 
 

 --JOB을 기준으로 내림차순정렬하고 JOB이 같으면 급여를 기준으로 정렬
select empno, ename, job, sal
from emp where sal >= 2000
order by job desc;


--별칭은 조건으로 사용할 수 없음
select empno, ename, job, sal
from emp where sal >= 2000
order by 3 desc; --index sort

-- 컬럼들끼리의 연산 가능
select empno, ename, sal, comm, sal + comm -- 연산할 때 null이 있으면 결과는 null로
from emp;

-- nvl() >> null 값을 다른 값으로 변경해서 연산 가능
select comm, nvl(comm, 100) from emp;

select empno, ename, sal, comm, sal + nvl(comm, 0) 급여, (sal + nvl(comm, 0)) * 12 연봉 -- 연산할 때 null이 있으면 결과는 null로
from emp;



-----------------------------------------------------------------------------------
/*
  연산자 종류
  1) 산술연산자
     +, -, *, / 
     나머지 : MOD(값, 나눌수)
     
   2) 관계연산자
       > , <, >= , <= , !=
       같다  :  =
       
   3) 비교연산자
    - AND
    - OR
    - IN :  컬럼명 IN (값, 값, 값)  - 하나의 컬럼을 대상으로 또는으로 비교할때 사용한다.
    
    - BETWEEN AND :  컬럼명 BETWEEN 최소 AND 최대 - 하나의 컬럼을 대상으로 최소 ~ 최대를 비교할때
    
    - LIKE  : 와일드카드 문자와 함께 사용한다.
        1. % : 0개이상의 문자
        2. _ : 한글자  
        
        EX)  name like 'J%' ;   - NAME에 첫글자가 J로 시작하는 모든 문자
             name like '___' ;  - NAME이 3글자 
             name like 'J_J%';  - NAME의 첫글자가 J로 시작하고 3번째 글자 A인 정보 검색
             
    
    - NOT : 위의 모든 연산자들 앞에 NOT을 붙히면 반대 개념.
        
*/

--EX) SAL 가 2000 ~ 4000사원 검색(AND, BETWEEN AND )
select * from emp
where sal between 2000 and 4000;
-- and 는 양 수의 순서를 바꿀 수 있지만 between은 바꿀 수 없음


--EX) SAL 가 2000 ~ 4000사원아닌 레코드 검색 -  NOT
select * from emp
where not sal between 2000 and 4000
order by sal;


--EX) EMPNO 가 7566, 7782,7844인 사원검색 ( OR, IN)
select * from emp
where empno in (7566, 7782, 7844);




--EX) EMPNO 가 7566, 7782,7844인 사원이 아닌 검색 ( NOT)
select * from emp
where empno not in (7566, 7782, 7844);

---------------------------------------------------------------------------
--1) JOB에 'A' 문자로시작하는 레코드 검색
select * from emp
where job like 'A%';


--2) JOB에 끝 끌자가 'N'으로 끝나는 레코드 검색
select * from emp
where job like '%N';


--3) ENAME이 4글자인 레코드 검색
select * from emp
where ename like '____';


--4) ENAME에 A글자가 포함된 레코드 검색
select * from emp
where ename like '%A%';

select * from emp;

--5) ENAME전체 글자가 5글자이고 두번째 글자가 m이면서끝글자가 h인 레코드 검색
select * from emp
where ename like '_M__H';

------------------------------------------------------------------

/*
null 찾기 > is null, is not null
*/

select * from emp
where comm is null;

select * from emp
where comm is not null;


select * from emp;
update emp set comm = 100 where comm is null;

rollback;

select * from emp
order by comm asc; -- null은 마지막에 조회

select * from emp
order by comm asc nulls first;

select rownum, empno, ename from emp;

select rownum, e.* 
from emp e;

select rownum, e.* 
from emp e
order by comm desc; -- 실행순서 issue >> subquery 사용

select rownum, e.*
from (select * from emp order by comm desc nulls last) e
where rownum <= 2;

/*
any = some : 검색 결과와 하나 이상 일치하면 참 (or 느낌)

all : 검색 결과가 모두 일치해야만 참 (and 느낌)
*/

select sal from emp where deptno = 30;

select * from emp
where sal >all(select sal from emp where deptno = 30);

