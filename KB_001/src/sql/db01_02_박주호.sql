CREATE TABLE users
( 
    user_seq   NUMBER,
    name  VARCHAR2(50),
    email      VARCHAR2(50),
    phone      VARCHAR2(15),
    is_sleep    CHAR(1)
);

alter table users add constraint users_pk primary key (user_seq);


alter table users add unique(email);
alter table users modify email not null;

alter table users modify  (is_sleep  default 'N');


desc users;

insert into users (user_seq, name, email, phone) values (111, '홍길동', 'hong@gildong@com', '010-1111-1111');
insert into users (user_seq, name, email, phone) values (222, '이길동', 'lee@gildong@com', '010-2222-2222');
insert into users (user_seq, name, email, phone) values (333, '삼길동', 'sam@gildong@com', '010-3333-3333');

select * from users;

update users set is_sleep = 'Y' where user_seq = 222;
select * from users where user_seq = 222;

   user_seq : 222,
   name : ‘이길동2’
   email : ‘lee2@gildong.com’
   phone : ‘010-2222-2222’

insert into users (user_seq, name, email, phone) values (222, '이길동2', 'lee2@gildong@com', '010-2222-2222');
-- ORA-00001: unique constraint (SYSTEM.USERS_PK) violated

   user_seq : 2222,
   name : ‘이길동2’
   email : ‘lee@gildong.com’
   phone : ‘010-2222-2222’

insert into users (user_seq, name, email, phone) values (2222, '이길동2', 'lee@gildong@com', '010-2222-2222');
-- ORA-00001: unique constraint (SYSTEM.SYS_C007011) violated -- SYS_C007011 은 이름을 부여하지 않아 자동으로 생긴 이름


   user_seq : 2222,
   name : ‘이길동2’
   phone : ‘010-2222-2222’

insert into users (user_seq, name, phone) values (2222, '이길동2', '010-2222-2222');
-- ORA-01400: cannot insert NULL into ("SYSTEM"."USERS"."EMAIL")


   user_seq : 2222,
   name : ‘이길동2’
   email : ‘lee2@gildong.com’
   phone : ‘010-2222-2222’

insert into users (user_seq, name, email, phone) values (2222, '이길동2', 'lee2@gildong@com', '010-2222-2222');



delete from users where user_seq = 2222;


drop table users;

