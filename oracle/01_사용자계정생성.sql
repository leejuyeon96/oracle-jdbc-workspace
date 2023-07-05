-- 사용자 계정 생성하는 구문 : 관리자 계정만이 할 수 있는 역할
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER kh IDENTIFIED BY kh;

-- 위에서 만들어진 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
-- [표현법] GRANT 권한 1, 권한 2, ... TO 계정명;
-- RESOURCE는 객체(생성, 수정, 삭제), 데이터(입력, 수정, 조회, 삭제) 권한 
-- CONNECT 권한이 없으면 해당 유저로 접속이 되지 않음
GRANT RESOURCE, CONNECT TO kh;

-- TABLESPACE에 대한 권한 부여
GRANT UNLIMITED TABLESPACE TO kh;

--과제 관련
CREATE USER study IDENTIFIED BY study;
GRANT RESOURCE, CONNECT TO study;
GRANT UNLIMITED TABLESPACE TO study;

--DDL 관련 계정
CREATE USER ddl IDENTIFIED BY ddl;
GRANT RESOURCE, CONNECT TO ddl;
GRANT UNLIMITED TABLESPACE TO ddl;

<<<<<<< HEAD
--JDBC 관련 계정
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT RESOURCE, CONNECT TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;








=======

-- 지금 오라클을 21c로 설치했는데요. 21c에서는 사용자 아이디가 c## 붙여야 함!
CREATE USER c##kh IDENTIFIED BY kh;
GRANT RESOURCE, CONNECT TO c##kh;
GRANT UNLIMITED TABLESPACE TO c##kh;

CREATE USER c##study IDENTIFIED BY study;
GRANT RESOURCE, CONNECT TO c##study;
GRANT UNLIMITED TABLESPACE TO c##study;

CREATE USER c##ddl IDENTIFIED BY ddl;
GRANT RESOURCE, CONNECT TO c##ddl;
GRANT UNLIMITED TABLESPACE TO c##ddl;
>>>>>>> 61eb5a3c3b7ea03225cf9831216621219a0213a1
