1. 고객번호 ( user_seq ) 가 111 인 계좌 ( account ) 테이블을 조회한다.

select * from account where user_seq = 111;


2. 잔고 ( balance ) 가 5000 미만인 계좌 ( account ) 테이블을 조회한다.

select * from account where balance < 5000;


3. 잔고 ( balance ) 가 5000 이상 10000 이하인 계좌 ( account ) 테이블을 조회한다.

select * from account where balance between 5000 and 10000;


4. 계좌번호 ( accountNumber ) 중 ‘4’ 를 포함하는 계좌 ( account ) 테이블을 조회한다. 

select * from account where account_number like '%4%';


5. 고객명 ( name ) 이 ‘삼‘ 을 시작하는 고객 ( users ) 테이블을 조회한다.

select * from users where name like '삼%';


6. 계좌 ( account ) 테이블에 있는 고객 번호 ( user_seq ) 를 중복없이 조회한다.

select distinct( user_seq ) from account;


7. 잔고 ( balance ) 가 없는 ( null ) 계좌 ( account ) 테이블을 조회한다.

select * from account where balance is null;


8. 고객번호 ( user_seq ) 가 있는 계좌 ( account ) 테이블을 조회한다.

select * from account where user_seq is not null;


9. 고객번호 ( user_seq ) 가 있고, 잔고가 4000 이하인 계좌 ( account ) 테이블을 조회한다.

select * from account 
 where user_seq is not null
   and balance <= 4000;


10. 계좌 ( account ) 테이블을 고객번호 ( user_seq ) 기준으로 오름차순으로 정렬하여 조회한다.
   
select * from account order by user_seq asc; 


11. 계좌 ( account ) 테이블을 고객번호 ( user_seq ) 기준으로 오름차순으로, 
그리고 그 안에서 잔고( balance ) 기준으로 내림차순으로 정렬하여 조회한다.
   
select * from account order by user_seq asc, balance desc; 


12. 계좌 ( account ) 테이블을 조회하되, balance 값이 없으면 0 으로 표시한다.

select account_seq, account_number, nvl(balance, 0), user_seq from account;


13. 고객 ( users ) 테이블을 조회하되, email은 @포함 뒷 부분은 빼고 앞 아이디만 표시한다. 컬럼명도 email 대신 email_id 로 변경한다.

select user_seq, substr( email, 0, instr(email, '@')-1 ) email_id, phone, is_sleep from users;


14. 고객 ( users ) 테이블을 조회하되, phone 의 ‘-’ 를 제외하고 표시한다. 컬럼명도 phone_short 로 변경한다.

select user_seq, email, replace(phone,'-','') phone_short, is_sleep from users;


------------------------------------------------------------------------------------------------------

--15. 계좌 ( account ) 테이블에서 고객번호 ( user_seq ) 가 222 인 건 수를 조회한다.

select count(*) from account where user_seq = 222;


--16. 계좌 ( account ) 테이블의 전체 잔고 ( balance ) 의 합을 조회하고 balance_sum 으로 표시한다.

select sum(balance) balance_sum from account;


--17. 계좌 ( account ) 테이블의 잔고 중 최소갑과 최대값을 조회하고 각각  balance_min, balance_max 로 표시한다.

select min(balance) balance_min, max(balance) balance_max from account;


--18. 계좌 ( account ) 테이블에서 고객번호와 고객번호 ( user_seq ) 별 계좌 건수를 조회하고 
--user_account_cnt 로 표시한다. 단, 고객번호 ( user_seq ) 가 없는 건은 제외한다.

select user_seq, count(*) user_account_cnt
  from account
 where user_seq is not null
 group by user_seq;


--19. 계좌 ( account ) 테이블에서 고객번호와 고객번호 ( user_seq ) 별 잔고의 합을 조회하고 user_balance_sum 로 표시한다. 
--단, 고객번호 ( user_seq ) 가 없는 건은 제외한다.
 
select user_seq, sum(balance) user_balance_sum
  from account
 where user_seq is not null
 group by user_seq;


--20. 위 19번의 결과 중 user_balance_sum 이 10000 이하인 건만을 조회한다.

select user_seq, sum(balance) user_balance_sum
  from account
 where user_seq is not null
 group by user_seq
 having sum(balance) <= 10000;
 