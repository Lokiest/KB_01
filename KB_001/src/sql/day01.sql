CREATE TABLE MEMBER(
  ID VARCHAR2(20) CONSTRAINT MEMBER_ID_PK PRIMARY KEY ,
  NAME VARCHAR2(10) NOT NULL,
  JUMIN CHAR(13) ,
  AGE NUMBER(2) , -- -99 ~ 99
  ADDR VARCHAR2(10 CHAR) ,
  REG_DATE DATE
);

--���̺� �˻�
SELECT * FROM MEMBER;

--���̺� ����
DESC MEMBER;


/*
  ���ڵ� ���
  INSERT INTO ���̺��̸�(�÷���, �÷���,....) VALUES(��, ��,��,....);
  INSERT INTO ���̺��̸� VALUES(��, ��,��,....); -- ��� �÷��� ������� ���� ������!!!
*/

INSERT INTO MEMBER VALUES('JANG','������','1111',20,'����','2022-1-20');
INSERT INTO MEMBER(ID,NAME) VALUES('HEE','����');

--�ߺ�
INSERT INTO MEMBER(ID,NAME) VALUES('HEE','ȿ��');--X

INSERT INTO MEMBER(ID,NAME) VALUES('hee','ȿ��'); --�����ʹ� ��ҹ��� �ٸ���.  

INSERT INTO MEMBER(NAME) VALUES('ȿ��'); --X

INSERT INTO MEMBER(ID,NAME) VALUES('AA','�ҳ�ô�'); --X
INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('BB','����','����� ������ ����'); --O

INSERT INTO MEMBER(ID,NAME,ADDR) VALUES('CC','����','����� ������ ����22'); --X

INSERT INTO MEMBER(ID,NAME, AGE) VALUES('DD','����',100);  --X
INSERT INTO MEMBER(ID,NAME, AGE) VALUES('DD','����',99);
INSERT INTO MEMBER(ID,NAME, AGE) VALUES('FF','����',-99);

INSERT INTO MEMBER(ID,NAME, REG_DATE) VALUES('EE','ȿ��',SYSDATE);

--���ڵ� �˻�
SELECT * FROM MEMBER;


--char vs varchar2 ��
INSERT INTO MEMBER(ID, NAME, JUMIN) VALUES('GG','A','B');

INSERT INTO MEMBER(ID, NAME, JUMIN) VALUES('TT','A ','B ');


--VARCHAR2 �� 
SELECT * FROM MEMBER WHERE NAME ='A ';

-- CHAR ��
SELECT * FROM MEMBER WHERE JUMIN ='B ';
---------------------------------------------------------
/*
  ���̺� ����
  DROP TABLE ���̺��̸�;
*/

drop table member;

CREATE TABLE MEMBER(
  ID VARCHAR2(20) ,
  NAME VARCHAR2(10) NOT NULL,
  JUMIN CHAR(13) ,
  AGE NUMBER(2) ,
  ADDR VARCHAR2(10 CHAR) ,
  REG_DATE DATE ,
  CONSTRAINT MEM_ID_JUMIN_PK PRIMARY KEY(ID,JUMIN)
);

INSERT INTO MEMBER VALUES('JANG','����','11111',15, NULL ,SYSDATE);

INSERT INTO MEMBER(ID,JUMIN , NAME) VALUES('JANG','22222','����');

INSERT INTO MEMBER(ID,JUMIN , NAME) VALUES('HEE','22222','����');

select * from member;

CREATE TABLE DEPT(
  DEPT_CODE CHAR(3) CONSTRAINT DEPT_CODE_PK  PRIMARY KEY,
  DNAME VARCHAR2(30) NOT NULL,
  LOC VARCHAR2(50)
);
INSERT INTO DEPT VALUES('A01','�渮��','����');
INSERT INTO DEPT VALUES('A02','������','�뱸');
INSERT INTO DEPT VALUES('A03','�����','����');

select * from dept;

CREATE TABLE  EMP(
  EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
  ENAME VARCHAR2(10) NOT NULL,
  SAL NUMBER(5),
  DEPT_CODE CHAR(3) CONSTRAINT EMP_CODE_FK REFERENCES DEPT(DEPT_CODE) ,  -- FK
  HIREDATE DATE DEFAULT SYSDATE --�⺻������
);

INSERT INTO EMP(EMP_NO, ENAME, SAL, DEPT_CODE)VALUES(100,'������',3000,'A01');

INSERT INTO EMP VALUES(200,'��ȿ��',1500,'A01',NULL);

INSERT INTO EMP VALUES(300,'�̹̼�',200,NULL , DEFAULT);

DELETE FROM DEPT WHERE DEPT_CODE='A03'; --����

DELETE FROM EMP WHERE DEPT_CODE='A01'; --�ڽ� ����
DELETE FROM DEPT WHERE DEPT_CODE='A01'; --�θ� ���� 

DROP TABLE EMP;
DROP TABLE DEPT;

CREATE TABLE DEPT(
  DEPT_CODE CHAR(3) CONSTRAINT DEPT_CODE_PK  PRIMARY KEY,
  DNAME VARCHAR2(30) NOT NULL,
  LOC VARCHAR2(50)
);
INSERT INTO DEPT VALUES('A01','�渮��','����');
INSERT INTO DEPT VALUES('A02','������','�뱸');
INSERT INTO DEPT VALUES('A03','�����','����');

CREATE TABLE  EMP(
  EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
  ENAME VARCHAR2(10) NOT NULL,
  SAL NUMBER(5),
  DEPT_CODE CHAR(3) CONSTRAINT EMP_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE CASCADE ,  -- FK
  HIREDATE DATE DEFAULT SYSDATE --�⺻������
);

CREATE TABLE  EMP(
  EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
  ENAME VARCHAR2(10) NOT NULL,
  SAL NUMBER(5),
  DEPT_CODE CHAR(3) CONSTRAINT EMP_CODE_FK REFERENCES DEPT(DEPT_CODE) ON DELETE set null ,  -- FK
  HIREDATE DATE DEFAULT SYSDATE --�⺻������
);

CREATE TABLE  EMP(
  EMP_NO NUMBER(3) CONSTRAINT EMP_NO_PK PRIMARY KEY,
  ENAME VARCHAR2(10) NOT NULL,
  SAL NUMBER(5),
  DEPT_CODE CHAR(3) CONSTRAINT EMP_fk REFERENCES DEPT(DEPT_CODE) ,  -- FK
  HIREDATE DATE DEFAULT SYSDATE --�⺻������
);


INSERT INTO EMP VALUES(200,'��ȿ��',1500,'A01',NULL);
INSERT INTO EMP VALUES(300,'������',1500,'A01',NULL);
INSERT INTO EMP VALUES(400,'������',1500,'A02',NULL);

DELETE FROM DEPT WHERE DEPT_CODE='A01';

--����!!!!!
/*
   ���ڵ� �������
    1) ROLLBACK ó������ - DML
      DELETE [FROM] ���̺��̸�
      [WHERE ���ǽ�]
      
        * FROM ��������, WHERE���� ������ ��� ���ڵ尡 �����ȴ�.
          
    2) ROLLBACK �ȵȴ�. - DDL
     TRUNCATE TABLE ���̺��̸�; --��緹�ڵ带 ����
      
*/
commit;
rollback;

/*
  3) UNIQUE
      : �ߺ��ȵ�, NULL���(NOT NULL�� �����ϸ� PK�� ����) 
      : �ĺ�Ű�߿� ��ǥŰ�� �ɼ� ���� Ű�� UNIQUE �����Ѵ�. 
      :  �����̺� �������� �÷��� ��������
      
  4) CHECK
      : ������ �����Ͽ� ���ǿ� �������� �ʴ� ������ INSERT �Ҽ� ����!
    
  
  5) DEFAULT
      : �⺻�� ����(���ֻ��Ǵ� ���� �̸� �����س��� �ڵ����� ���� ���� �ֶǷ� �ϴ°�)
      : EX) �����, ��ȸ��....
      : DEFAULT�� �����Ҷ��� CONSTRAINT ��Ī�� �Ⱦ���!!!
      : NOT NULL�� �����ϸ� DEFALUT�� �Բ� ����Ҷ��� �ݵ�� DEFAULT�� ���� �ۼ��Ѵ�.
*/

CREATE TABLE TEST(
  ID VARCHAR2(10)  PRIMARY KEY,
  JUMIN CHAR(13) NOT NULL UNIQUE,
  NAME VARCHAR2(10) UNIQUE, --�ߺ�X, NULL���
  AGE NUMBER(2) CHECK(AGE >=20 AND AGE <= 30),
  GENDER CHAR(3) CHECK(GENDER='��' OR GENDER='��'),
  LOC VARCHAR2(10) DEFAULT '����',
  REG_DATE DATE  DEFAULT SYSDATE NOT NULL -- �����߿�
);


DROP TABLE TEST;
SELECT * FROM TEST;

INSERT INTO TEST VALUES('JANG','111','����',22,'��',DEFAULT, DEFAULT);

INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('HEE','222','����',22,'��');

INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('KIM',NULL,'��',22,'��');--JUMIN�� NULL��� X
INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('KIM','222','��',22,'��');--JUMIN�� �ߺ� ��� X


INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('AA','333',NULL,22,'��'); --NAME�� NULL��� O
INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('BB','444',NULL,22,'��');  --NAME�� �� NULL��� O

INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('CC','55','����',31,'��'); -- ����üũ X

INSERT INTO TEST(ID,JUMIN,NAME,AGE,GENDER) VALUES('DD','555','ȿ��',26,'M');  --����üũ X

/*
  ���̺� ����
  
 �� �÷��߰�
  alter table ���̺��̸� add 
     (�÷��� �ڷ��� [��������] , �÷��� �ڷ��� [��������] , ....)
 
 �� �÷�����
 alter table ���̺��̸� drop column �÷��̸�
 
 �� datatype����
    alter table ���̺��̸� modify �÷��̸� �����ڷ���
    
�� �÷��̸� ����
 alter table ���̺��̸� rename column �����÷��� to �����÷���
 
 �� �������� �߰�
  alter table ���̺��̸� ADD CONSTRAINT ��Ī ������������ ;
  
 -�������� ����
  ALTER TABLE ���̺��̸� DROP CONSTRAINT ��Ī;
  
 
 - ���̺� ����
 drop table ���̺��̸�

*/

SELECT * FROM TEST;
ALTER TABLE  TEST ADD (PHONE VARCHAR2(10) , ETC VARCHAR2(20) DEFAULT '��Ÿ' NOT NULL );

 alter table TEST ADD CONSTRAINT PHONE_CK CHECK(PHONE='1111' OR PHONE='2222');
 
 ALTER TABLE TEST DROP CONSTRAINT PHONE_CK;
 
 /*
SQL�� ����
 - DDL����(CREATE, DROP, ALTER, TRUNCATE)
 - DML����(INSERT ,UPDATE, DELETE)
*/

/*
  ������ ���� : DML(INSERT , UPDATE, DELETE)
   - ROLLBACK OR COMMIT ����
   
   1) INSERT����
       -INSERT INTO ���̺��̸�(�÷���, �÷���,....) VALUES(��, ��,��,....);
       -INSERT INTO ���̺��̸� VALUES(��, ��,��,....); -- ��� �÷��� ������� ���� ������!!!
   
   2) DELETE����
       DELETE [FROM] ���̺��̸�
       [WHERE ���ǽ�]
   
   3) UPDATE����
      UPDATE ���̺��̸�
      SET �÷���=���氪 , �÷���=���氪,....
      [WHERE ���ǽ�] 

*/
--�������̺� �ʿ��ϴ�. 
/*
   --���̺� ����
   CREATE TABLE ���̺��̸�
   AS ���������̺�����;
   
   
    ���� : ���̺��� �����ϸ� ���������� ���� �ȵȴ�!!! - �������Ŀ� ���������� ALTER�� �̿��ؼ� �߰��Ѵ�.

*/

--1)����÷�, ��緹�ڵ� �����ϱ�
CREATE TABLE COPY_EMP
AS SELECT *FROM EMP;

SELECT * FROM COPY_EMP;

--2)���ϴ� �÷�, ���ϴ� ���ڵ常 �����ϱ�
CREATE TABLE COPY_EMP2
AS SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO=20;

SELECT * FROM COPY_EMP2;


--3)���̺��� ������ �����ϱ� 
CREATE TABLE COPY_EMP3
AS SELECT * FROM EMP WHERE 1=0;

SELECT * FROM COPY_EMP3;
DESC COPY_EMP3;


--COPY_EMP ���̺��� ������ ����, ����
SELECT * FROM COPY_EMP;












