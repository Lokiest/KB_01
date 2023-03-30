insert into users (user_seq, name, email, phone) values (444, '사길동', 'sa@gildong@com', '010-4444-4444');
insert into users (user_seq, name, email, phone) values (555, '오길동', 'o@gildong@com', '010-5555-5555');



CREATE TABLE account
( 
    account_seq   NUMBER,
    account_number VARCHAR2(50) not null,
    balance       NUMBER,
    user_seq      NUMBER,
	CONSTRAINT account_pk PRIMARY KEY (account_seq)
);

insert into account (account_seq, account_number, balance, user_seq) values (50, '00500505005005', 3000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (10, '00100101001001', 1000, 111);
insert into account (account_seq, account_number, balance, user_seq) values (30, '00300303003003', 5000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (70, '00700707007007', 7000, 444);
insert into account (account_seq, account_number, balance, user_seq) values (40, '00400404004004', 4000, 222);
insert into account (account_seq, account_number, balance, user_seq) values (60, '00600606006006', 2000, 222);
insert into account (account_seq, account_number) values (80, '00800808008008');
insert into account (account_seq, account_number, balance, user_seq) values (20, '00200202002002', 6000, 111);

drop table users;
CREATE TABLE users
( 
    user_seq   NUMBER,
    name  VARCHAR2(50),
    email      VARCHAR2(50),
    phone      VARCHAR2(15),
    is_sleep    CHAR(1)
);

select * from users
where user_seq = 111;

select * from account
where balance < 5000;

select * from account
where balance between 5000 and 10000;

select * from account
where account_number like '%4%';

select * from users
where name like '삼%';

select distinct user_seq from account;

select * from account
where balance is null;

select * from account
where user_seq is not null;

select * from account
where user_seq is not null and balance <= 4000;

select * from account
order by user_seq;

select * from account
order by user_seq, balance desc;

select account_seq, account_number, nvl(balance, 0), user_seq from account;

select user_seq, name, email, replace(phone, '-', '') phone_num from users;

select count(*) from account
where user_seq = 222;

select sum(balance) balance_sum from account;

select max(balance) Max, min(balance) Min from account;

