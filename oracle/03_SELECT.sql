/*
  - 데이터(data) : 필요에 의해 수집했지만 아직 특정 목적을 위해 정제하지 않은 값
    vs 정보(info) : 수집한 데이터를 어떠한 목적을 위해 분석하거나 가공하여 새로운 의미 부여
  
  - 데이터베이스 : 데이터(data) + 베이스(base)
  - DBMS : Database Management System의 약자, 데이터베이스 관리 시스템
  
  - 관계형(Relational) 데이터베이스
    1. 가장 대표적인 데이터베이스 시스템
    2. 데이터를 테이블 형태로 저장하고 여러테이블을 조합하여 비즈니스 관계를 도출하는 구조
    3. 데이터의 중복을 최소화할 수 있으며 사용하기 편리하고 데이터의 무결성, 트랙잭션 처리 등 데이터베이스 관리 시스템으로 뛰어난 성능을 보여준다.
  
  - SQL(Structured Query Language)
    : 관계형 데이터베이스에서 데이터를 조회하거나 조작하기 위해 사용하는 표준 검색 언어
  
  - SQL 종류
    1.DDL(Data Definition Language) : 데이터 정의어 - DBMS의 구조를 정의하거나 변경, 삭제하기 위해 사용하는 언어(CREATE 생성, ALTER 수정, DROP 삭제) - 테이블
    2.DML(Data Manipulation Language) : 데이터 조작어 - 실제 데이터를 조작하기 위해 사용하는 언어(INSERT 삽입, UPDATE 수정, DELETE 삭제) - 데이터
    3.DQL(Data Query Language) : 데이터 질의어 - 데이터를 조회(검색)하기 위해 사용하는 언어(SELECT)
    4.DCL(Data Control Language) : 데이터 제어어 - DMBS에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어(GRANT 권한 부여, REVOKE 권한 회수)
    5.TCL(Transaction Control Language) : 트랜잭션을 제어하는 언어(COMMIT 실행, ROLLBACK 취소)
    
    
    SELECT
    [표현법]
    SELECT 컬럼, [, 컬럼, ...]
    FROM 테이블명;
    - 테이블에서 데이터를 조회할 때 사용하는 SQL문
    - SELECT를 통해서 조회된 결과를 RESULT SET 이라고 한다. (즉, 조회된 행들의 집합)
    - 조회하고자 하는 컬럼들은 반드시 FROM 절에 기술한 테이블에 존재하는 컬럼이어야 한다.
    - 모든 컬럼을 조회할 경우 컬럼명 대신 * 기호 사용\
    

  */
   -- EMPLOYEE 테이블에 전체 사원의 모든 컬럼(*) 정보 조회       
  SELECT *
  FROM EMPLOYEE;
  
  --EMPLOYEE 테이블의 전체 사원들의 사번EMPID, 이름EMPNAME, 급여SALARY만을 조회
  SELECT EMP_ID, EMP_NAME, SALARY
  FROM EMPLOYEE;
  
  --대소문자를 가리지 않지만 관례상 대문자로 작성
  
  --실습문제----------------------------------
  --1. JOB 테이블의 모든 정보 조회
  SELECT *
  FROM JOB;
  
  --2. JOB 테이블의 직급 이름 조회
  SELECT JOB_NAME 
  FROM JOB;
 
  --3. DEPARTMENT 테이블의 모든 정보 조회
  SELECT *
  FROM DEPARTMENT;
  
  --4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 정보만 조회
  SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
  FROM EMPLOYEE;
  
  