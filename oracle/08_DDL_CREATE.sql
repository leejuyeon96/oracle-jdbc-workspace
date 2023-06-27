/*
* DDL (DATA DEFINITION LANGUAGE) : 데이터 정의어
   - 오라클에서 제공하는 객체(OBJECT) / 스키마(SCHEMA) 를 만들고 (CREATE) 변경하고  (ALTER) 삭제(DROP) 하는 언어
   - 즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
   - 주로 DB 관리자, 설계자가 사용
   
    *오라클에서 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
    , 프로시저(PROCEDURE), 함수(FUNCION), 동의어(SYNONYM), 사용자(USER)
*/
/*
*  CREATE
 - 객체를 생성하는 구문
 
 *테이블 생성
 - 테이블이란? 행ROW 과 열COLUMN 로 구성되는 가장 기본적인 데이터베이스 객체
 - 데이터베이스 내에 모든 데이터는 테이블에 저장!
[표현식]
CREATE TABLE 테이블명 (
    컬럼명 자료형(크기),
    컬럼명 자료형(크기),
    컬럼명 자료형(크기),
    ...
);
    *자료형
    1. 문자(CHAR/VARCHAR2) - 반드시 크기 지정 해야함
        CHAR : 최대 2000BYTE 까지 저장 가능, 고정 길이(아무리 적은 값이 들어와도 처음 할당된 크기 그대로), 고정된 글자수의 데이터만이 담길 경우 사용
        VARCHAR2 :  최대 4000BYTE 까지 저장 , 가변길이 (담긴 값에 따라서 공간의 크기 맞춰줌), 몇글자의 데이터가 들어올지 모를 경우 사용
    2. 숫자(NUMBER) 
    3. 날짜(DATE) 
*/
--회원에 대한 데이터를 담을 MEMBER 테이블 생성
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PW VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

--테이블 구조를 표시해주는 구문
DESC MEMBER;
/*
데이터 딕셔너리
 - 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
 - 사용자가 객체를 생성하거나 객체를 변경하는 등의 작업을 할 때 데이터베이스 서버에 의해서 자동으로 갱신되는 테이블
*/

--USER_TABLES : 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TABLES;

SELECT * 
FROM USER_TABLES 
WHERE TABLE_NAME = 'MEMBER';

--USER_TAB_COLUMNS : 사용자가 가지고 있는 테이블들 상의 모든 컬럼의 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TAB_COLUMNS;

/*
컬럼 주석
- 테이블 컬럼에 대한 설명을 작성할 수 있는 구문

 [표현법]
 COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
 
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.MEM_GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

--테이블에 데이터 추가시키는 구문 (DML : INSERT)
--INSERT INTO 테이블명 VALUES(값,값,값...);
INSERT INTO MEMBER VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1111-2222', 'AAA@NAVER.COM', '23/06/26');

INSERT INTO MEMBER VALUES(2, 'USER02', 'PASS02', '홍길녀', '여', NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SELECT * FROM MEMBER;

/*
* 제약조건(CONSTRAINTS)
 - 사용자가 원하는 조건의 데이터만 유지하기 위해서 각 컬럼에 대해 저장될 값에 대한 제약조건을 설정
 - 제약조건은 데이터 무결성 보장을 목적으로 한다.(데이터의 정확성과 일관성을 유지시키는 것)
 - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
 [표현법]
 1) 컬럼 레벨 방식
 CREATE TABLE 테이블명 (
    컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
    ...
    );
 2) 테이블 레벨 방식
 CREATE TABLE 테이블명(
    컬럼명 자료형(크기),
    ...
    [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
)
*/
/*
*   NOT NULL 제약조건
    -해당 컬럼에 반드시 값이 존재해야만 하는 경우
    (즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
    -삽입/수정시 NULL 값을 허용하지 않도록 제한
    -오로지 컬럼 레벨 방식으로만 설정 가능!!
*/
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOTNULL VALUES(1, 'USER01', 'PASS01', '홍길동', '남', NULL, NULL);

INSERT INTO MEM_NOTNULL VALUES(2, 'USER02', NULL, '김말순', '여', NULL, 'AAA@NAVER.COM');

--> NOT NULL 제약조건에 위배되어 오류 발생!

INSERT INTO MEM_NOTNULL VALUES(2, 'USER01', 'PASS02', '강개똥', NULL, NULL, NULL);

SELECT * FROM MEM_NOTNULL;

/*
UNIQUE 제약 조건
- 해당 컬럼에 중복된 값이 들어와서는 안 되는 경우
- 컬럼값에 중복값을 제한하는 제약조건
- 삽입/수정시 기존에 있는 데이터 값 중 중복값이 있을 경우 오류 발생
*/

--컬럼 레벨 방식
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
DROP TABLE MEM_UNIQUE;
--테이블 레벨 방식 : 모든 컬럼들 다 나열 후 마지막에 기술
CREATE TABLE MEM_UNIQUE(
  MEM_NO NUMBER NOT NULL,
  MEM_ID VARCHAR2(20) NOT NULL,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  UNIQUE(MEM_ID)
 );
);
INSERT INTO MEM_UNIQUE VALUES(1, 'USER01', 'PASS01', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(2, 'USER02', 'PASS02', '강개똥', NULL,NULL,NULL);
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패!
--> 오류구문에 제약조건명으로 알려줌!
--> 제약조건 부여시 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해버림

/*
*제약조건 부여시 제약조건 명까지 지어주는 방법
> 컬럼레벨방식 
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건
        ...
    );
>테이블레벨방식
     CREATE TABLE 테이블명 (
        컬럼명 자료형, 
        ...,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
 MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
  MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
  MEM_PWD VARCHAR2(20) CONSTRAINT MEMPW_NN NOT NULL,
  MEM_NAME VARCHAR2(20) CONSTRAINT MEMRENAME_NN NOT NULL,
  GENDER CHAR(3),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
 );

    
);
INSERT INTO MEM_UNIQUE VALUES(1, 'USER01', 'PASS01', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(2, 'USER02', 'PASS02', '홍길녀', 'ㅇ', NULL, NULL);

SELECT * FROM MEM_UNIQUE;

/*
CHECK(조건식) 제약조건
- 해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해볼 수 있음!
- 해당 조건에 만족하는 데이터 값만 담길 수 있음
*/
DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
 
);
    


INSERT INTO MEM_CHECK VALUES(1, 'USER01', 'PASS01', '홍길동','남', NULL, NULL);

INSERT INTO MEM_CHECK VALUES(2, 'USER02', 'PASS02', '홍길녀', 'ㅇ', NULL, NULL);

INSERT INTO MEM_CHECK VALUES(2, 'USER02', 'PASS02', '홍길녀', '여', NULL, NULL);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(2, 'USER03', 'PASS03', '강개순', '여', NULL, NULL);

/*
PRIMARY KEY(기본키) 제약조건
 - 테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건(식별자 역할)
 EX) 회원번호, 학번, 사원번호, 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호, ....
 - PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건이 설정
 - 한 테이블 당 오로지 한 개만 설정 가능
*/
CREATE TABLE MEM_PRI(
  MEM_NO NUMBER,-- CONTRAINT MEMNO_PK PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK(GENDER IN ('남', '여')) NOT NULL,
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) --> 테이블 레벨 방식
);
);
INSERT INTO MEM_PRI VALUES(1,'USER01', 'PASS01', '강개순', '여', '010-1111-2222', NULL);
INSERT INTO MEM_PRI VALUES(1,'USER02', 'PASS02', '이순신', '남', NULL, NULL);

--> 기본키 중복값을 담으려고 할 때(UNIQUE 제약조건 위배)

INSERT INTO MEM_PRI VALUES(NULL, 'USER02', 'PASS02', '이순신', '남', NULL, NULL);

--> 기본키 NULL을 담으려고 할 때 (NOT NULL 제약조건 위배)

INSERT INTO MEM_PRI VALUES(2, 'USER02', 'PASS02', '이순신', '남', NULL, NULL);

SELECT * FROM MEM_PRI;

DROP TABLE MEM_PRI2;
CREATE TABLE MEM_PRI2(
  MEM_NO NUMBER,-- CONTRAINT MEMNO_PK PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  PRIMARY KEY(MEM_NO, MEM_ID)--> 묶어서 PRIMARY KEY 제약조건 부여 ---복합키
);
INSERT INTO MEM_PRI2 VALUES(1, 'USER01', 'PASS01', '홍길동', NULL, NULL, NULL);
INSERT INTO MEM_PRI2 VALUES(1, 'USER02', 'PASS02', '홍길녀', NULL, NULL, NULL);

-- 복합키 사용 예시 (어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER, PRODUCT_NAME VARCHAR2(10), LIKE_DATE DATE, PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);
INSERT INTO TB_LIKE VALUES(1,'A', SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'B', SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'A', SYSDATE);

-- 회원 등급에 대한 데이터를 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY, 
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  GRADE_ID NUMBER --> 회원등급번호 보관할 컬럼
);
INSERT INTO MEM VALUES(1, 'USER01', 'PASS01', '홍길순', '여', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER02', 'PASS02', '김말똥', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER03', 'PASS03', '강개순', '남', NULL, NULL, 40);
--> 유효한 회원등급 번호가 아님에도 불구하고 INSERT! 아직 연결 X
SELECT * FROM MEM;

/*
    *FOREIGN KEY(외래키) 제약조건
     - 외래키 역할을 하는 컬럼에 부여하는 제약조건   
     - 다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약조건(단, NULL 값도 가질 수 있음)
        --> 다른 테이블을 참조한다고 표현
        --> 주로 FOREIGN KEY 제약조건에 의해 테이블간의 관계가 형성됨!
        [표현법]
        > 컬럼레벨방식
        컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명 [(참조할컬럼명)]
        
        > 테이블레벨방식
        [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)]
        
        --> 참조할 컬럼명을 생략시 참조할 테이블명에 PRIMARY KEY로 지정된 컬럼으로 매칭
*/
DROP TABLE MEM;
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) --> 컬럼 레벨 방식
); --테이블 레벨 방식 : FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)

INSERT INTO MEM VALUES(1, 'USER01', 'PASS01', '홍길순', '여', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER02', 'PASS02', '김말똥', NULL, NULL, NULL, 10);
INSERT INTO MEM VALUES(3, 'USER03', 'PASS03', '강개순', '남', NULL, NULL, 40);

-- MEM_GRADE(부모 테이블) -|-------<- MEM(자식테이블)

--> 이때 부모테이블 (MEM_GRADE)에서 데이터값을 삭제할 경우 문제 발생!
--데이터 삭제: DELETE FROM 테이블명 WHERE 조건;

-->MEM_GRADE 테이블에서 10번 등급 삭제!
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE=10;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE= 30;
--> 자식 테이블이 이미 사용하고 있는 값이 있을경우 부모 테이블로부터 무조건 삭제가 안되는 삭제제한 옵션이 걸려있음

ROLLBACK;

SELECT * FROM MEM_GRADE; --30이 다시 돌아옴!

/*
    자식테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    *삭제옵션 : 부모테이블의 데이터 삭제 시 그 데이터를 사용하고 있는 자식 테이블의 값을 어떻게 처리할 건지 
    - ON DELETE RESTRICTED(기본값)
        : 삭제 제한 옵션으로, 자식 데이터로 쓰이는 부모 데이터는 삭제 아예 안되게끔
    - ON DELETE SET NULL 
        : 부모 데이터 삭제시 해당 데이터를 쓰고 있는 자식 데이터의 값을 NULL 로 변경
    - ON DELETE CASCADE
        : 부모 데이터 삭제시 해당 데이터를 쓰고 있는 자식 데이터도 같이 삭제시킴      
        
*/
DROP TABLE MEM;
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
);
INSERT INTO MEM VALUES(1, 'USER01', 'PASS01', '홍길순', '여', NULL, NULL, NULL);
INSERT INTO MEM VALUES(2, 'USER02', 'PASS02', '김말똥', NULL, NULL, NULL, 10);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE= 10;

ROLLBACK;

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

-- ON DELETE CASCADE
 DROP TABLE MEM;
 CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR(20) NOT NULL,
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET CASCADE
 );
 INSERT INTO MEM VALUES(1, 'user01', 'pass01', '홍길순', '여', NULL, NULL, NULL);
 INSERT INTO MEM VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 10);
 DELETE FROM MEM_GRADE
 WHERE GRADE_CODE = 10;
 SELECT * FROM MEM_GRADE;
 SELECT * FROM MEM;
 /*
 DEFAULT 기본값
    - 제약조건 아님!
    - 컬럼을 선정하지 않고 INSERT시 NULL이 아닌 기본값을 INSERT 하고자 할 때 세팅해둘 수 있는 값
    [표현식]
    컬럼명 자료형 DEFAULT 기본값 [제약조건]
 */
 DROP TABLE MEMBER;
 CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
 );
 INSERT INTO MEMBER VALUES(1, '강길동', 20, '운동','23/1/1');
 INSERT INTO MEMBER VALUES(2, '홍길순', NULL, NULL, NULL);
 INSERT INTO MEMBER VALUES(3, '김말똥', NULL, DEFAULT, DEFAULT);
-- INSERT INTO MEMBER VALUES(4, '강개순');
 SELECT * FROM MEMBER;
 --- KH 계정----------------------------------------------------------------------------------------------------------------------
 /*
    서브쿼리를 이용한 테이블 생성
    - 테이블 복사하는 개념
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
 */
 CREATE TABLE EMPLOYEE_COPY
 AS SELECT * FROM EMPLOYEE;
 SELECT * FROM EMPLOYEE_COPY;
 CREATE TABLE EMPLOYEE_COPY2
 AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
 FROM EMPLOYEE
 WHERE 1 = 0;    -- 이 조건이 달리면 데이터값 복사 안됨! -> 구조만 복사하고자 할 때 쓰이는 구문
 SELECT * FROM EMPLOYEE_COPY2;
 CREATE TABLE EMPLOYEE_COPY3
 AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "연봉"
 FROM EMPLOYEE;
 SELECT * FROM EMPLOYEE_COPY3;
 -----------------------------------------------------------------------------------------------------------------------------


CREATE TABLE TB_PUBLISHER(
 PUB_NO NUMBER,
 PUB_NAME VARCHAR2(30) NOT NULL,
 PHONE VARCHAR2(20)
 CONSTRAINT TB_PUBLISHER_PUB_NO_PK PRIMARY KEY(PUB_NO)
 );
 
 INSERT INTO TB_PUBLISHER VALUES (1, '인사이트', '02-1111-2222');
 INSERT INTO TB_PUBLISHER VALUES (2, '제이펍', '02-3333-4444');
 INSERT INTO TB_PUBLISHER VALUES (3, '한빛미디어', '02-5555-6666');
SELECT * FROM TB_PUBLISHER;

--삭제하는 순서가 중요 --중요함
DROP TABLE TB_RENT;
DROP TABLE TB_MEMBER;
DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;


CREATE TABLE TB_BOOK(
 BK_NO NUMBER,
 BK_TITLE VARCHAR2(100) NOT NULL,
 BK_AUTHOR VARCHAR2(20) NOT NULL,
 BK_PRICE NUMBER,
 BK_PUB_NO NUMBER
 CONSTRAINT TB_BOOK_BK_NO_PK PRIMARY KEY(BK_NO), --PK??
 CONSTRAINT TB_BOOK_BK_PUB_NO FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER ON DELETE CASCADE
 );
 
 INSERT INTO TB_BOOK VALUES(1, '프로그래머 열정을 말하다', '채드 파울러', 12600, 1);
 INSERT INTO TB_BOOK VALUES(2, '1일 1로그 100일 완성 IT 지식', '브라이언', 18000, 1);
 INSERT INTO TB_BOOK VALUES(3, '인스파이어드', '마티 케이건', 21600, 2);
 INSERT INTO TB_BOOK VALUES(4, '혼자 공부하는 얄팍한 코딩 지식', '고현민', 16200, 3);
 INSERT INTO TB_BOOK VALUES(5, '함께 자라기', '김창준', 11700, 1);

SELECT * FROM TB_BOOK;
--회원 테이블
CREATE TABLE TB_MEMBER(
 MEMBER_NO NUMBER,
 MEMBER_ID VARCHAR2(20) UNIQUE,
 MEMBER_PWD VARCHAR2(30) NOT NULL,
 MEMBER_NAME VARCHAR2(20) NOT NULL,
 GENDER CHAR(1) CHECK(GENDER IN ('M', 'F')),
 ADDRESS VARCHAR2(100),
 PHONE VARCHAR2(20),
 STATUS VARCHAR2(1) DEFAULT 'N' CHECK(STATUS IN ('Y','N')),
 ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL ,
 CONSTRAINT TB_MEMBER_MEMBER_NO_PK PRIMARY KEY(MEMBER_NO)
 );
 
 INSERT INTO TB_MEMBER VALUES (1, 'USER1', '1234', '유병재', 'M', '서울시 강남구', '010-1111-2222', 'N', '23/06/27');
 INSERT INTO TB_MEMBER VALUES (2, 'USER2', '1234', '김동현', 'M', '서울시 강남구', '010-3333-4444', 'N', '23/06/27');
 INSERT INTO TB_MEMBER VALUES (3, 'USER3', '1234', '강호동', 'F', '서울시 강남구', '010-5555-6666', 'N', '23/06/27');

CREATE TABLE TB_RENT(
 RENT_NO NUMBER,
 RENT_MEM_NO NUMBER,
 RENT_BOOK_NO NUMBER,
 RENT_DATE DATE DEFAULT SYSDATE,
 CONSTRAINT TB_RENT_RENT_NO_PK PRIMARY KEY(RENT_NO),
 CONSTRAINT TB_RENT_RENT_MEM_NO_FK FOREIGN KEY(RENT_MEM_NO)
                        REFERENCES TB_MEMBER ON DELETE SET NULL,
 CONSTRAINT TB_RENT_RENT_BOOK_NO_FK FOREIGN KEY(RENT_BOOK_NO)
                        REFERENCES TB_BOOK ON DELETE SETNULL
);
 INSERT INTO TB_RENT VALUES (1, 1, 2, DEFAULT);
 INSERT INTO TB_RENT VALUES (2, 1, 3, '23/06/27');
 INSERT INTO TB_RENT VALUES (3, 2, 1, '23/06/27');
 INSERT INTO TB_RENT VALUES (4, 2, 2, '23/06/27');
 INSERT INTO TB_RENT VALUES (5, 1, 5, '23/06/27');
 
 SELECT * FROM TB_RENT;
 
 SELECT MEMBER_NAME, MEMBER_ID, RENT_BOOK_NO, RENT_DATE, RENT_DATE+7
 FROM TB_MEMBER TM, TB_RENT TR
 WHERE TM.MEMTER_NO = TR_RENT_MEM_NO
 AND RENT_BOOK_NO = 2;

--6. 
SELECT BK_TITLE, PUB_NAME, RENT_DATE, RENT_DATE + 7
FROM TB_RENT TR
JOIN TB_BOOK TB ON (TR.RENT_BOOK_NO = TB.BK_NO)
JOIN TB_PULISHER TP ON (TB.BK_PUB_NO = TP.PUB_NO)
WHERE RENT_MEM_NO =1;

/*
    DB 모델링 작업 순서
        1. 개념적 모델링
            - 엔티티추출
            - 엔티티 간의 관계설정
        2. 논리적 모델링
            - 속성 추출
            - 정규화 작업(1, 2, 3) 3까지만 추천함 
        3. 물리적 모델링
            - 테이블 실질적으로 작성        

    *정규화(Normalization)
     - 불필요한 데이터의 중복을 제거하여 데이터모델을 구조화하는 것
     - 효율적인 자료 저장 및 데이터 무결성을 보장하고 오류를 최소화하여 안정성을 보장하기 위해 적용
     
    제1 정규화 : 복수의 속성값을 갖는 속성을 분리
    제2 정규화 : 주 식별자에 종속되지 않는 속성을 분리
    제3 정규화 : 속성에 종속적인 속성 제거
    
*/












