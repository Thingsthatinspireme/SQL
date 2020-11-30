--[join]
--관계형 데이터 베이스 시스템 (oracle, MY SQL(Maria), SQL-Server(MS-SQL)...)
--테이블과 테이블이 연관 관계를 맺고 있다
-- 등가조인 : 같은값을 연결 시킴 / 두테이블의 공통 컬럼을 = 연산자로 조건을 부여한 것


SELECT eno 사번, ename 이름, emp.dno 부서번호 --dno는 두 테이블에 다 있기 때문에 어디서 가져올것인지 표시
FROM emp, dept          --이름도 같고 자료형도 같아야지 JOIN연산 가능
WHERE emp.dno = dept.dno; --같은 값을 연결시켰기 때문에 등가조인이라 부름

-- 비등가 조인 : 겹치는 칼럼은 없지만 어떤 칼럼이 다른 칼럼의 범위를 나타 낼 수 있으면 사용한다 
--3)각 직원의 급여를 10% 인상한 경우 급여 등급을 검색한다
SELECT eno 사번, ename 이름, sal * 1.1 "인상된 급여", grade 등급
FROM emp, salgrade
WHERE sal * 1.1 BETWEEN losal AND hisal;

--4)잘못된 조인(Cross Join)
﻿-- 조인 조건이 없으면 Cross Join 이라고 하며 테이블들의 모든 행이 1:1 교차하게 된다.
-- 결과에 의미가 없다.
SELECT d.dno, dname, e.dno, ename
FROM dept d, emp e;

--[Self Join - 자기 참조 조인] 자기 테이블 안에서 자기 정보들을 조인
--﻿e1 : 사원테이블 / e2 : 관리자 테이블
--WHERE e1.mgr = e2.eno : 사원의 관리자  =  관리자 사번
SELECT e1.eno 사번, e1.ename 사원명, e1.mgr 관리자사번, e2.eno 관리자사번, e2.ename 관리자명 
FROM emp e1, emp e2 --별명부여
WHERE e1.mgr = e2.eno;
﻿
--[외부조인]
--2)각 부서별로 사원을 검색한다
﻿
--일반조인  
SELECT d.dno 부서번호, dname 부서명, ename 사원명
FROM dept d, emp e
WHERE d.dno=e.dno
ORDER BY 1;

--외부조인[outer 조인]﻿
--부서는 존재하지만 소속 부서원이 존재하지 않을 경우 일반 조인을 사용하면 부서가 나타나지 않음
--이 때 '외부조인'을 사용하면 소속부서원이 없는 부서도 표시된다.
--(+)는 데이터가 부족한 컬럼에 적어야 한다, 빈 공간(null)이라도 추가하라는 뜻
--외부조인의 가장 중요한 의미는 출력데이터의 신뢰성 제공이다.
--양쪽의 데이터가 일치하지 않을 때 외부조인을 통해 모두 표현하므로 업무상 신뢰를 상승시킴

SELECT d.dno 부서번호, dname 부서명, ename 사원명
FROM dept d, emp e
WHERE d.dno=e.dno(+)
ORDER BY 1;

SELECT e1.eno 사번, e1.ename 사원명, e1.mgr 관리자사번, e2.eno 관리자사번, e2.ename 관리자명 
FROM emp e1, emp e2 --별명부여
WHERE e1.mgr = e2.eno(+);--null값도 츨력됨

[Join을 표현하는 여러가지 방법]
[Natural Join - 자연조인 ] : 컬럼이름과 자료형이 일치하는 것을 찾아서 Join 해준다.

1)자연 조인으로 각 사원의 근무 부서를 검색하세요
﻿
SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
NATURAL JOIN dept;
[Using 절을 이용한 Join] 
 :Natural Join은 공통 컬럼이 1개만 존재할 때 사용할 수 있다. 둘이상인 경우에는 사용할 수 없다.
﻿  이때 = 등가 조인이나 Using 절을 이용한 Join을 사용해야 한다

3)Using절 조인으로 각 사원의 근무 부서를 검색하세요
﻿
SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
JOIN dept USING (dno); --공통컬럼을 지정해서 조인을 걸어주는 방법 

--[ON절]
--:가독성이 우수하다 (조인조건을 명시적으로 표현)
--등가 조인과 비등가 조인을 모두 표현할 수 있다.

--1) 각 사원의 근무부서를 검색하세요
﻿--등가조인
SELECT eno 사번, ename 이름, dept.dno 부서번호, dname 부서명
FROM emp
JOIN dept ON emp.dno =  dept.dno; 

--[좌우 외부 조인 (Left Right Outer Join)]
--(+)기호로 하는 외부 조인은 둘중에 한쪽에만 사용 가능하다 그러나 여기서는 마치 양쪽에 (+)를
--것 같은 표현이 가능 하다.
--a.(+) : pos부서는 존재, pos에 부서원이 없을 때 : dept.dno = emp.dno(+)
--b.부서원이 없는 pos부서 존재, 홍길동 신입사원이 부서가 배정되기 전 이럴경우는 FULL JOIN을 사용해야 한다.

--1)사원이름과 소속부서를 검색하세요

SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
RIGHT JOIN dept USING (dno); --오른쪽인 dept를 기준으로 매칭되지 않아도 오른쪽 다 출력

SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
LEFT JOIN dept USING (dno); --왼쪽인 emp를 기준으로 매칭되지 않아도 왼쪽 다 출력

SELECT eno 사번, ename 이름, dno 부서번호, dname 부서명
FROM emp
FULL JOIN dept USING (dno); --양쪽다 검색되게 하기 
