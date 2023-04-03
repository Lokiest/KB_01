1. ����ȣ ( user_seq ) �� 111 �� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account where user_seq = 111;


2. �ܰ� ( balance ) �� 5000 �̸��� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account where balance < 5000;


3. �ܰ� ( balance ) �� 5000 �̻� 10000 ������ ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account where balance between 5000 and 10000;


4. ���¹�ȣ ( accountNumber ) �� ��4�� �� �����ϴ� ���� ( account ) ���̺��� ��ȸ�Ѵ�. 

select * from account where account_number like '%4%';


5. ���� ( name ) �� ��� �� �����ϴ� �� ( users ) ���̺��� ��ȸ�Ѵ�.

select * from users where name like '��%';


6. ���� ( account ) ���̺� �ִ� �� ��ȣ ( user_seq ) �� �ߺ����� ��ȸ�Ѵ�.

select distinct( user_seq ) from account;


7. �ܰ� ( balance ) �� ���� ( null ) ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account where balance is null;


8. ����ȣ ( user_seq ) �� �ִ� ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account where user_seq is not null;


9. ����ȣ ( user_seq ) �� �ְ�, �ܰ� 4000 ������ ���� ( account ) ���̺��� ��ȸ�Ѵ�.

select * from account 
 where user_seq is not null
   and balance <= 4000;


10. ���� ( account ) ���̺��� ����ȣ ( user_seq ) �������� ������������ �����Ͽ� ��ȸ�Ѵ�.
   
select * from account order by user_seq asc; 


11. ���� ( account ) ���̺��� ����ȣ ( user_seq ) �������� ������������, 
�׸��� �� �ȿ��� �ܰ�( balance ) �������� ������������ �����Ͽ� ��ȸ�Ѵ�.
   
select * from account order by user_seq asc, balance desc; 


12. ���� ( account ) ���̺��� ��ȸ�ϵ�, balance ���� ������ 0 ���� ǥ���Ѵ�.

select account_seq, account_number, nvl(balance, 0), user_seq from account;


13. �� ( users ) ���̺��� ��ȸ�ϵ�, email�� @���� �� �κ��� ���� �� ���̵� ǥ���Ѵ�. �÷��� email ��� email_id �� �����Ѵ�.

select user_seq, substr( email, 0, instr(email, '@')-1 ) email_id, phone, is_sleep from users;


14. �� ( users ) ���̺��� ��ȸ�ϵ�, phone �� ��-�� �� �����ϰ� ǥ���Ѵ�. �÷��� phone_short �� �����Ѵ�.

select user_seq, email, replace(phone,'-','') phone_short, is_sleep from users;


------------------------------------------------------------------------------------------------------

--15. ���� ( account ) ���̺��� ����ȣ ( user_seq ) �� 222 �� �� ���� ��ȸ�Ѵ�.

select count(*) from account where user_seq = 222;


--16. ���� ( account ) ���̺��� ��ü �ܰ� ( balance ) �� ���� ��ȸ�ϰ� balance_sum ���� ǥ���Ѵ�.

select sum(balance) balance_sum from account;


--17. ���� ( account ) ���̺��� �ܰ� �� �ּҰ��� �ִ밪�� ��ȸ�ϰ� ����  balance_min, balance_max �� ǥ���Ѵ�.

select min(balance) balance_min, max(balance) balance_max from account;


--18. ���� ( account ) ���̺��� ����ȣ�� ����ȣ ( user_seq ) �� ���� �Ǽ��� ��ȸ�ϰ� 
--user_account_cnt �� ǥ���Ѵ�. ��, ����ȣ ( user_seq ) �� ���� ���� �����Ѵ�.

select user_seq, count(*) user_account_cnt
  from account
 where user_seq is not null
 group by user_seq;


--19. ���� ( account ) ���̺��� ����ȣ�� ����ȣ ( user_seq ) �� �ܰ��� ���� ��ȸ�ϰ� user_balance_sum �� ǥ���Ѵ�. 
--��, ����ȣ ( user_seq ) �� ���� ���� �����Ѵ�.
 
select user_seq, sum(balance) user_balance_sum
  from account
 where user_seq is not null
 group by user_seq;


--20. �� 19���� ��� �� user_balance_sum �� 10000 ������ �Ǹ��� ��ȸ�Ѵ�.

select user_seq, sum(balance) user_balance_sum
  from account
 where user_seq is not null
 group by user_seq
 having sum(balance) <= 10000;
 