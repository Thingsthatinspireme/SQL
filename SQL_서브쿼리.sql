
*서브쿼리

- 서브쿼리는 두개의 쿼리를 결합하여 하나의 문장으로 표현하는 것이다

- 서브쿼리는 WHERE절, HAVING절과 같이 조건절에 주로 쓰인다.

- FROM절에 쓰이는 서브쿼리는 인라인 뷰(Inline View)라고 불린다.


1)단일 행 서브쿼리 : 서브쿼리가 하나의 컬럼에서 하나의 행을 검색한다


2) 다중 행 서브쿼리 : 서브쿼리가 하나의 컬럼에서 여러개의 행을 검색한다


3) 다중 열 서브쿼리 : 서브쿼리가 여러개의 컬럼을 검색한다




*단일 행 연산자와 같이 사용되는 서브쿼리 (=, >, <, <=, >=, !=)


- 단일 행 연산자가 사용될때는 서브쿼리의 결과값이 1개만 검색되어야한다

- 서브쿼리는 반드시 괄호로 묶어준다

- 서브쿼리는 메인쿼리 실행전에 실행된다.

- 서브쿼리의 검색값은 메인쿼리에 사용된다

- 단일 행 연산자의 오른쪽에 기술한다

- WHERE절에 기술된 열의 숫자와 타입은 SELECT절과 1:! 대응관계가 되어야 한다.


김연아의 급여와 비교하여 더 많이 받는 사원을 검색한다

SELECT eno , ename "김연아급여보다 높음", sal
FROM emp
WHERE sal > (SELECT sal
             FROM emp
             WHERE ename = '김연아');
내용을 입력하세요.

*예측하기 힘든 단일 행 서브쿼리를 수정하는 방법

-'='연산자는 'IN'연산자로 바꾼다 : 다중행 서브쿼리로 전환


노육과 평점이 동일한 학생의 정보를 검색하라

SELECT sno, sname, avr
FROM student
WHERE avr IN (SELECT avr
             FROM student
             WHERE sname='노육');
내용을 입력하세요.
- 부등호(<, >, <=, >=) 는 any, all - 다중행 서브쿼리로 전환, 연산자를 추가한다

- Max, Min 그룹함수를 사용한다


*다중 행 서브 쿼리 (결과 값이 여러개의 행이다)

- 서브쿼리에 여러개의 행이 검색되는 쿼리를 다중행 서브쿼리라 칭한다

- 다중행 서브쿼리는 다중행 연산자를 이용한다.


*다중행 연산자의 종류

- IN : 검색된 값중에 하나만 일치하면 참

- ANY : 검색된 값중에 조건에 맞는 것이 하나 이상 있으면 참

- ALL : 모든 검색된 값과 조건에 맞아야 참


10번 부서원들보다 급여가 낮은 사원을 검색한다

SELECT eno, ename, dno, sal
FROM emp
WHERE sal < ALL(SELECT sal
                FROM emp
                WHERE dno = '10')-- 10번부서의 가장 작은값보다 작다
AND dno != '10';     
내용을 입력하세요.
- 컬럼 > ALL => 컬럼 > MAX : 가장 큰 값보다 크다

- 컬럼 < ALL => 컬럼 < MIN : 가장 작은 값보다 작다

- 컬럼 > ANY => 컬럼 > MIN : 가장 작은 값보다 크다

- 컬럼 < ANY => 컬럼 < MAX : 가장 큰 값보다 작다


손하늘과 동일한 관리자의 관리를 받으면서 업무도 같은 사원을 검색한다.

SELECT eno, ename, mgr, job
FROM emp
WHERE (mgr, job) IN (SELECT mgr,job
                     FROM emp
                     WHERE ename = '손하늘')
AND ename != '손하늘';       

SELECT * FROM emp;
내용을 입력하세요.
-손하늘 사원이 여러 명이면 다중 열 서브쿼리로만 가능하다.


SELECT eno, ename, mgr, job
FROM emp
WHERE mgr = (SELECT mgr
             FROM emp
             WHERE ename = '손하늘')
AND job = (SELECT job
             FROM emp
             WHERE ename = '손하늘')             
AND ename != '손하늘';
내용을 입력하세요.
-손하늘 사원이 1명만 존재한다면 단일 행 서브쿼리로 가능하다

﻿