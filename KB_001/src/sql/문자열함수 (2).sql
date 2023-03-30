/*
문자열 함수
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
 데이터 타입 변환 to_char, to_date, to_number
*/


select ename, comm, sal, coalesce(comm, sal, 50) result
from emp;

/*
 EX) EMP테이블에서 DEPNO가 10 이면 관리부, 20이면 총무부, 30이면 영업부 
     이외의 값은 기타부 로 출력하고 컬럼명은 부서명 으로 한다.
     (DECODE, CASE END)

ex)job이 manager인 경우 sal*0.1, ANALYST 인경우는   sal *0.2
     SALESMAN인 경우는 sal * 0.3을 구해서 성과급 필드를 만든다.
      (case end, decode 다 해본다) 


ex) sal이 2000이하이면 '저소득층'
      sal이 2001 ~ 4000사이면 '중산층'
      sal이 4001 이상이면 '고소득층'  구하여 등급 별칭 해준다.
      (case end) 
*/

select empno, ename, job, deptno, decode(deptno, 10, '관리부', 20, '총무부', 30,'영업부','기타부') 부서명
from emp;

select empno, ename, job, deptno,
case deptno when 10 then '관리부' when 20 then '총무부' when 30 then '영업부' end 부서명 from emp;

select e.*,
case job when 'MANAGER' then sal* 0.1 when 'ANALYST' then sal * 0.2 when 'SALESMAN' then sal * 0.3 end 성과급
from emp e;

select e.*,
case when sal <= 2000 then '저' when sal between 2001 and 4000 then '중' when sal >=4001 then '고' end 등급
from emp e;
