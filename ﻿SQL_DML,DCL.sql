
*DML (Data Manipulation Language)

- 데이터베이스에 데이터를 입력, 수정, 삭제하는 명령이다. SELECT문과는 다르게 데이터베이스의 내용을

변경하는 작업을 수행함으로 SELECT 문에 비해서 훨씬 주의깊게 계획되고 실행되어야 한다. 이렇게 DML작업은

이전과는 달리 안전한 작업과정과 결과가 요구됨으로 이를 위해 오라클은 DML 작업을 트랜잭션이라는 단위로

관리한다.


*INSERT


INSERT INTO 테이블[(컬럼, 컬럼, ...)]

VALUES (값, 값, ...);


1) INSERT문은 하나의 행만을 삽입한다

2) 컬럼 리스트와 VALUE절의 값은 반드시 1: 1로 대응된다

3) 테이블의 모든 컬럼에 값을 입력하는 경우 컬럼 리스트를 생략할 수 있다. VALUE 절에 기술하는 값의 순서는

DESC 명령으로 확인된 테이블의 컬럼 순서와 일치해야 한다

4) 입력되는 값이 숫자가 아닌 경우 반드시 단일 인용부호를 사용한다

5) INSERT 문장에서 생략된 컬럼은 null값이 입력된다

6) 명시적인 null값은 'null'을 기술한다

7) 값 대신 DEFAULT를 기술하면 DEFAULT값이 입력된다

8) 데이터를 넣을 때 자료형을 일치시켜야 한다 - 정형데이터


--1901 권준연 요리      2020-02-01 5000 2000 10를 INSERT 하시오

INSERT INTO emp (eno, ename, job, hdate, sal, comm, dno)
VALUES('1901', '권준연', '요리', '2020-02-01', 5000, 2000, '10');
내용을 입력하세요.
- mgr 컬럼값을 입력해주지 않았기 때문에 null으로 나오게 된다

- 만약 데이터 타입이 NUMBER인 sal컬럼에 문자열인 '구천'을 넣어주면 오류가 발생


--emp 
--사번 : 1910
--이름 : 장나라 
--입사일 : 2020-01-02:07:15:29

INSERT INTO emp (eno, ename, hdate)
VALUES('1910', '장나라', '2020-01-02:07:15:29'); 
--오류발생

INSERT INTO emp (eno, ename, hdate)
VALUES('1910', '장나라', TO_DATE('2020-01-02:07:15:29', 'YYYY/MM/DD:HH24:MI:SS')); 
내용을 입력하세요.
- 세션 날짜 형식과 맞지 않아서 입력 오류가 발생하게 된다

- TO_DATE함수를 이용하면 원하는 날짜와 시간이 세션포멧과 일치하지 않아도 INSERT해줄 수 있다

- ALTER SESSION SET을 사용해줘도 되지만 TO_DATE를 사용해주면 나라와 시간에 상관없이 입력 가능




*UPDATE

UPDATE 테이블

SET 컬럼 = 값, 컬럼 = 값,...

[WHERE 조건];


1) 컬럼의 값을 수정한다

2) WHERE 절을 생략하면 모든 행의 지정된 컬럼값이 수정된다

3) 여러 컬럼의 값을 동시에 수정할 수 있다

4) 값 대신에 DEFAULT를 기술하면 테이블에 정의된 DEFAULT값으로 변경된다


이승철의 부서번호를 10번으로 수정하고 급여를 10% 인상하자

UPDATE emp SET
 dno ='10', sal = sal*1.1
 WHERE ename = '이승철'; 
내용을 입력하세요.


*DELETE


DELETE FROM 테이블

[WHERE 조건];


1) 행단위로 데이터를 삭제한다

2) 조건이 없는 경우 테이블의 모든 행을 삭제한다

3) 테이블을 삭제해도 테이블의 물리적인 구조는 변하지 않는다 (공간을 차지하고 있다)


화학과 2학년 학생의 정보를 삭제하세요

DELETE
FROM student
WHERE major '화학' AND syear = 2;
내용을 입력하세요.

*DCL (Data Control Language)

1) COMMIT

- 트랜잭션 작업을 완료한다

- 모든 DML 문장을 수행한 후 작업을 완료할 때 반드시 필요하다

- 오라클은 작업이전의 정보를 UNDO SEGMENT에 저장해놓고 업데이트된 새로운 정보가 테이블에 저장되게됨 ,                COMMIT되면 변경된값이 영원히 저장된다. 만약 A,B,C가 있고 A가 테이블의 구조를 바꾸던 중에 B에서 호출을 하면 COMMIT을 하기전에는 업데이트하기전 정보를 보여준다


2) ROLLBACK

- 작업을 취소한다

- 모든 DML문장을 수행한 후 작업을 취소할 때 반드시 필요하다



DELETE * FROM dept;

SELECT * FROM dept;

ROLLBACK; --취소 커밋하기전 원래 데이터 복원 가능

DELETE FROM dept;
COMMIT;--커밋

ROLLBACK; -- 데이터복원 불가능
SELECT * FROM dept;
내용을 입력하세요.


행 row

열 column




*서브쿼리를 이용한 DML문

- INSERT작업에 대량의 데이터를 입력할 때 서브쿼리문을 이용하면 작업속도가 더 빨라질 수 있다.

특히 메모리를 통하지않고 직접 데이터를 디스크에 입력하는 다이렉트 로드를 같이 사용하면 작업효과는 배가된

다. (메모리에 저장하면 모았다가 한번에 옮길 수 도 있고 안정성도 더 높아지긴 한다)

- 오라클안에서 SELECT작업이나 DML 작업은 모두 메모리에서 이루어진다. 오라클은 SGA라는 메모리 영역내에

데이터 베이스 버퍼 캐시 (Database Buffer Cache)라는 영역을 이들의 작업 공간으로 이용한다. 이를 통해 작업

을 모았다가 한번에 처리함으로써 디스크 접근 횟수와 양을 줄여 성능을 향상시킨다.

- 그러나 대량의 DML의 작업이 메모리에서 일어나면 이를 디스크에 반영하고 다시 메모리를 정리하는등 바로

디스크에 기록하는 것보다 비효율적인 작업이 된다. 이를 피하기 위해 대량 DML작업에서는 메모리를 통하지

않고 디스크에 직접 작업을 수행하는 작업을 다이렉트 로드 (Direct Load)라고 한다.


* INSERT INTO [/* + APPEND */] 테이블 [NOLOGGING] [(컬럼, 컬럼, 컬럼,...)]

SELECT 문장;

- 서브쿼리에 검색된 행을 입력값으로 사용한다

- 한번에 많은 행을 입력할 수 있다

- 컬럼 리스트와 SELECT 문의 컬럼의 1:1로 대응되어야 한다

- SELECT 문에 사용한 서브쿼리문과는 달리 괄호를 따로 사용하지 않는다

- 데이터 타입이 일치해야 한다

- [/* + APPEND */] : 다이렉트로 로드해줘서 대량의 입력 작업을 빠르게 수행한다

(INSERT 할 때 메모리를 거치지 않고 바로 디스크에 저장한다)

- NO LOGGING : 오라클은 모든 로그정보를 남기게 되어있지만 NOLOGGING을 사용하면 로그정보를 남기지

않게 되서 입력작업이 빨라진다. 그러나 장애상황 발생시에 복구가 불가능하다


 각 사원의 정보와 근무지를 emp3 테이블에 저장하라

DESC emp3;

INSERT /*+ APPEND */ INTO emp3 NOLOGGING (eno, ename, dno, dname)
 SELECT eno, ename, d.dno, dname
 FROM emp e, dept d
 WHERE d.dno = e.dno;

SELECT * FROM emp3; --병렬에러 발생

COMMIT;

SELECT * FROM emp3; --정상적으로 검색이됨
내용을 입력하세요.
- 오라클은 안전한 시스템 운영을 위해 장애 발생 시 복구 할 수 있도록 DB에 변경을 가하는 모든 작업의 내용을

리두 로그(Redo Log) 영역에 로그정보로 보관한다. 그러나 대량의 DML작업은 작업의 효율을 위해

NOLOGGING을 사용하여이를 수행 하지 않을 수 있다. 그러나 이렇게 복구가 불가능하도록 작업한 이후에는

장애에 대비하기위해 백업을 잊지 말 아야 한다. 작업성능은 향상되지만 작업이 안전도가 떨어지기 때문이다.


- 다이렉트 로드를 이용해서 대량의 데이터를 테이블에 입력한 경우 입력되는 물리적 위치가 일반 입력과 달라서

트랜잭션을 마무리하지 않고 검색하게 되면 'ORA-12838 : 병렬로 수정한 후 객체를 읽거나 수정할 수 없습니다'

라는 에러를 만나게 된다. 이것은 입력데이터의 손상을 방지하기 위한 기능으로 COMMIT을 한 이후 검색하면

정상적으로 검색이 된다.



*UPDATE 테이블

SET(컬럼,컬럼,...) = (SELECT 문장)

[WHERE 조건];

- UPDATE문의 SET절에는 단일행 서브쿼리문이나 다중열 서브쿼리문을 사용할 수 있다

- 다중열인 경우에도 결과행은 반드시 하나여야 한다

- 이때 검색되는 데이터는 반드시 수정되는 컬럼명과 1:1 대응돼야 한다

- SET절에는 단일행 서브쿼리만 허용되지만 WHERE절의 서브쿼리는 연산자에 따라 달라진다


UPDATE emp SET
 sal = (SELECT sal FROM emp WHERE ename = '김연아'),
 comm = (SELECT comm FROM emp WHERE ename = '손하늘')
WHERE ename = '윤고은';

SELECT * FROM emp; --전체검색
내용을 입력하세요.

화학과 교수의 과목 중에 학점이 3학점 미만인 과목을 모두 3학점으로 수정한 다음 이를 확인하세요

UPDATE course
SET st_num = 3
WHERE cname IN (SELECT cname
                FROM professor p, course c
                WHERE p.pno = c.pno
                AND section = '화학'
                AND st_num < 3);
--다중열 서브쿼리문을 통한 UPDATE문 연산자를 IN으로 사용해줘서 화학과 교수의 과목중 학점이 3학점
미만인 과목을 검색해주었다

SELECT * FROM course;

내용을 입력하세요.

UPDATE emp SET
 (sal, comm) = (SELECT sal, comm
                FROM emp
                WHERE ename = '김연아')
WHERE ename = '이초록';
내용을 입력하세요.
- 여러개를 업데이트 해야할 때는 묶어서 서브쿼리를 써주는게 성능이 좋은 SQL문이다

﻿