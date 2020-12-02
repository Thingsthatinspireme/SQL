
*JOIN


*등가조인 : 두 테이블의 공통된 컬럼을 = 연산자로 조건을 부여한다



각 사원의 근무 부서를 검색한다

SELECT eno 사번, ename 이름, emp.dno 부서번호 
FROM emp e, dept d --테이블에도 별명 부여 가능          
WHERE emp.dno = dept.dno; 
내용을 입력하세요.
-dno는 두 테이블에 다 있기 때문에 어디서 가져올것인지 표시

-이름도 같고 자료형도 같아야지 JOIN연산 가능

-같은 값을 연결시켰기 때문에 등가조인이라 부름


*비등가 조인 : 겹치는 칼럼은 없지만 어떤 칼럼이 다른 칼럼의 범위를 나타낼 수 있을때에 사용


각 직원의 급여를 10% 인상한 경우 급여 등급을 검색한다

SELECT eno 사번, ename 이름, sal * 1.1 "인상된 급여", grade 등급
FROM emp, salgrade
WHERE sal * 1.1 BETWEEN losal AND hisal; 
내용을 입력하세요.
-emp와 salgrade는 겹치는 칼럼은 없지만 salgrade가 emp테이블의 sal칼럼의 범위를 나타 내 줄 수 있다.


*잘못된 조인(Cross Join)

- 조인 조건이 없으면 Cross Join 이라고 하며 테이블들의 모든 행이 1:1 교차하게 되며 의미가 없는 결과값이 출력되어진다


SELECT d.dno, dname, e.dno, ename
FROM dept d, emp e;
내용을 입력하세요.

*자기참조조인

-자기 테이블 안에서 자기 정보들을 조인


각 사원을 관리하는 관리자(사수)의 이름을 검색하세요.
--﻿e1 : 사원테이블 / e2 : 관리자 테이블
--WHERE e1.mgr = e2.eno : 사원의 관리자  =  관리자 사번

SELECT e1.eno 사번, e1.ename 사원명, e1.mgr 관리자사번, e2.eno 관리자사번, e2.ename 관리자명 
FROM emp e1, emp e2 --별명부여
WHERE e1.mgr = e2.eno;
내용을 입력하세요.
-사원의 관리자사번(mgr)과 관리자의 사번(eno)이 동일한결과를 검색한다

-같은 테이블에게 각각의 별명을 부여하고 where절에서 조인조건을


*외부조인(OUTER JOIN)

-부서는 존재하지만 소속 부서원이 존재하지 않을 경우 일반 조인을 사용하면 부서가 나타나지 않는다

이때, '외부조인'을 사용하면 소속부서원이 없는 부서도 표시된다.

-(+)를 데이터가 부족한 컬럼에 적어주면 해당 컬럼의 빈공간에는 null값이 출력되게 된다.

-외부조인의 가장 중요한 의미는 출력데이터의 신뢰성 제공이다.

-양쪽의 데이터가 일치하지 않을 때 외부조인을 통해 모두 표현하므로 업무상 신뢰를 상승시킴


SELECT d.dno 부서번호, dname 부서명, ename 사원명
FROM dept d, emp e
WHERE d.dno=e.dno(+)  --부서를 배정받지 못한 사원도 출력됨
ORDER BY 1;
내용을 입력하세요.

SELECT e1.eno 사번, e1.ename 사원명, e1.mgr 관리자사번, e2.eno 관리자사번, e2.ename 관리자명 
FROM emp e1, emp e2 --별명부여
WHERE e1.mgr = e2.eno(+);--null값도 츨력됨 -- 관리자사번이 없는 경우에도 출력이 됨 
내용을 입력하세요.

*NATURAL JOIN(자연조인)

- 컬럼이름과 자료형이 일치하는 것을 찾아서 JOIN 해준다.

- 공통컬럼이 1개만 존재할 때 사용


자연 조인으로 각 사원의 근무 부서를 검색하세요

SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
NATURAL JOIN dept; --dno가 겹침
내용을 입력하세요.

SELECT sno 학번, sname 이름, cname 과목명, result 점수
FROM student
NATURAL JOIN score
NATURAL JOIN course
WHERE major='화학'
AND syear=1
AND cname='유기화학';
내용을 입력하세요.
-그러나 위의 예제같이 3개의 테이블에서 각각 겹치는 컬럼이 하나씩 있을때는 두번 연속으로

사용 가능함 (student.sno = score.sno / score.cno = course.cno)


*USING 절을 이용한 JOIN

-공통 컬럼이 둘 이상일 경우에도 사용이 가능하다.


USING 절 조인으로 각 사원의 근무 부서를 검색하세요
SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
JOIN dept USING (dno); --겹치는 칼럼을 괄호안에 써준다
내용을 입력하세요.

화학과 1학년 학생들의 유기화학 점수를 검색하세요

SELECT sno 학번, sname 이름, cno 과목코드, cname 과목명, result 점수
FROM student, score, course
JOIN score USING (sno)
JOIN course USING (cno)
WHERE major = '화학'
AND syear = 1
AND cname = '유기화학';
내용을 입력하세요.
-공통컬럼이 2개일 경우 USING절 2번 사용


*JOIN ON절

- 조인조건을 명시적으로 표현해주기 때문에 가독성이 우수하다

- 등가조인과 비등가 조인을 모두 표현할 수 있다

- 조인과 관련없는 job = '개발' 같은 일반 조건은 ON절보다 WHERE절에 사용해야 가독성이 더 좋아진다.


각 사원의 근무부서를 검색하세요

SELECT eno 사번, ename 이름, dept.dno 부서번호, dname 부서명
FROM emp
JOIN dept ON emp.dno=dept.dno;
내용을 입력하세요.
-등가 조인




개발 업무를 담당하는 사원의 급여 등급을 검색하세요

 SELECT eno 사번, ename 이름, job 업무, grade 급여등급
 FROM emp
 JOIN salgrade ON sal BETWEEN losal AND hisal
 WHERE job='개발';
내용을 입력하세요.
-비등가 조인



SQL문을 작성할때는 가독성이 좋게 작성해야 하므로 원칙을 정하는 것이 좋다.

예를 들어 등가조인은 USING절, 비등가 조인은 ON절 만을 사용하는 식이 있다.


*좌우 외부 조인 (LEFT RIGHT OUTER JOIN)

-(+)기호로 하는 외부조인은 둘중에 한쪽에만 사용이 가능하지만 LEFT RIGHT OUTER JOIN은 양쪽에 (+)를

사용한 것 같은 표현이 가능하다

-(+) : POS부서는 존재, POS에 부서원이 없을 때 dept.dno=emp.dno(+) /데이터가 부족한 쪽에 (+) 해줘야 함


사원 이름과 소속 부서를 검색하세요

SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp RIGHT JOIN dept USING(dno);
내용을 입력하세요.
-모든 사원의 목록이 출력된다.


SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
LEFT JOIN dept USING(dno);
내용을 입력하세요.
-모든 부서의 목록이 출력된다


SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
FULL JOIN dept USING(dno);
내용을 입력하세요.
-양쪽다 모든 값이 출력되며 서로 조인되지 않는 항목은 null값이 나오게 된다.



﻿