

SELECT * FROM emp; 
내용을 입력하세요.
-SQL은 명령어의 대소문자 구분이 존재하지 않는다. 하지만 관습적으로 하나는 대문자를 사용하면 나머지 하나는

소문자를 사용해서 구분해준다.


--주석처리 ctrl+/을누르면 전체 주석처리가 된다

-여러줄 주석할때에는 /* */사용가능


DESC EMP;
내용을 입력하세요.
-테이블 구조를 검색


SELECT eno, ename, job 
FROM emp;
내용을 입력하세요.
-원하는 정보만 검색이 가능하다


SELECT 2+3 
FROM dual;
내용을 입력하세요.
-연산도 가능하다


*별명설정


SELECT eno 사번, ename 이름, job 업무 
FROM emp;
내용을 입력하세요.
- 각각 컬럼에 원하는 별명을 지정해 줄 수 있다



*NVL함수


SELECT eno 사번, ename 이름, sal 급여, comm 보너스, sal * 12 + NVL(comm, 0) 연봉
FROM emp;
내용을 입력하세요.
-NVL 함수를 이용해서 null값을 0으로 지정해 줄 수 있다


*공백출력


SELECT ename|| ' ' || sal --' ' 한칸 공백이라는 뜻 
FROM emp;


SELECT major ||'학과인 '||sname||'학생의 평점은'|| avr || '입니다.' "학생 평점"
FROM student;
내용을 입력하세요.
- ||' '|| 한칸 공백이라는 뜻

- "학생 평점" 이렇게 끝에 사용해주면 검색제일 위 상단에 출력되서 나온다


*중복제거와 정렬


SELECT DISTINCT job 업무
FROM emp;
내용을 입력하세요.
-DISTINCT 중복제거를 하기위해 사용하는 명령어


SELECT eno 사번, ename 이름, sal 급여 
FROM emp
ORDER BY sal ASC; --오름차순 DEFALTE값

SELECT job 업무, eno 사번, ename 이름,  sal 급여 --job을 앞으로빼서 업무별로 묶었다는 사실을 깔끔하게 보여줄 수 있다 
FROM emp
ORDER BY 업무; --ASC는 생략가능 

SELECT eno 사번, ename 이름, sal 급여
FROM emp
ORDER BY sal DESC; --내림차순

SELECT eno 사번, ename 이름, sal*12+NVL(comm,0)연봉
FROM emp
ORDER BY 3 DESC; --3번째 컬럼을 기준으로 정렬해라 



내용을 입력하세요.
- ASC : 오름차순 정렬

-DESC : 내림차순 정렬


*wHERE(자바에서의 if문과 비슷)



SELECT eno 사번, ename 이름, sal 급여
FROM emp
WHERE sal >= 4000; --if문의 역할
내용을 입력하세요.
- WHERE을 통해서 조건을 설정해줄 수 있다

-WHERE절에서는 별명이 먹히지 않는다

-부등호는 항상 >=, <= 비교하는 부분이 > < 앞쪽에 나온다 그다음에 =가 나옴



SELECT eno, ename  --3
FROM emp  --1
WHERE dno = '20'; --2
내용을 입력하세요.
-테이블먼저 설정 -whrer조건절 확인 -출력

-WHERE절이 먼저 실행되고 출력이 된다.


SELECT *
FROM emp
WHERE dno !=10;

SELECT *
FROM emp
WHERE dno !='10';
내용을 입력하세요.
-dno는 VARCHAR2(2)인 문자열 자료형이다. 문자열로 10이 들어가기 때문에 작은 따옴표없이 숫자 10을 입력하게 되면 형변환이 일어나게 된다. 만약 코드가 길어지게 된다면 작업속도가 매우 저하되기 때문에 꼭 동일한 자료형으로 비교해주어야 한다.


-CHAR는 고정문자 10BYTE를 할당하면 10BYTE 보다 덜 입력해도 다 할당됨

-VARCHAR는 10BYTE라고 할당하고 3BYTE로 저장하면 3BYTE로 저장됨


*DATE

-외국에서는 날짜를 입력할때 DATE를 많이 사용하고 우리나라에서는 VARCHAR를 많이 사용한다.


입사일이 1996년 이후인 사원의 정보를 검색하세요

SELECT *
FROM emp
WHERE hdate > '1995/12/31'; --날짜는 문자열로 비교해야함 
내용을 입력하세요.

ALTER SESSION SET nls_date_format='YYYY/MM/DD'; --네자리 연도로 표현하겠다
내용을 입력하세요.
-실행하면 session SET이(가) 변경되었습니다. 라는 문구가 출력됨

-끄면 다시 기본 세팅값으로 돌아오게 됨


*NULL값의 검색


보너스 컬럼이 널 값인 사원을 검색하세요 

SELECT *
FROM emp
WHERE comm IS NULL;
내용을 입력하세요.
-IS NULL : null 값을 검색

-IS NOT NULL : 널이 아닌 값을 검색



*관계연산자 AND와 OR


30번 부서원 중에 급여가 2000이상이고 개발 업무를 담당하는 사원을 검색하세요
SELECT *
FROM emp
WHERE dno = '30' 
AND sal >= 2000
AND job = '개발';
내용을 입력하세요.
-AND를 사용해서 조건을 여러개 부여할 수 있다


SELECT *
FROM emp
WHERE dno = '10' OR sal > 1600 AND comm > 600;

SELECT *
FROM emp
WHERE (dno = '10' OR sal > 1600 )AND comm > 600;
내용을 입력하세요.
-관계연산자 우선순위 NOT > AND > OR

-AND가 먼저 연산되고 그다음 OR이 연산됨

-OR먼저 연산하고 싶으면 괄호로 묶어서 순서를 정해주면된다


*LIKE 연산자

1. 문자열을 검색시 사용

2. - '_' : 반드시 한개의 문자를 대체

-'%' : 문자열을 대체(문자가 없는 경우도 포함)

3. -LIKE '경%' => '경'으로 시작하는 모든 문자열 (경, 경제, 경영학과 이런식으로 검색됨

-'%과' => '과'로 끝나는 모든 문자열 (과, 다과, 화학과, 물리학과

-'%김%'=> '김'이라는 글자가 들어간 문자열 (김, 김씨, 돌김, 되새김질

-LIKE '화_' => '화'로 시작하는 두글자 단어 (화학, 화약, 화장, 화풍

-LIKE '__화' => '화'로 끝나는 세글자 단어 (무궁화, 해당화, 운동화, 들국화

-LIKE '_동_' => '동'이 가운데 들어간 세글자 단어 (원동기, 전동차

-언더바는 한글자를 대체한다는 의미고 퍼센트는 문자열을 대신한다는 의미


김씨 성을 가진 사원을 검색하세요

SELECT *
FROM emp
WHERE ename LIKE '김%';
내용을 입력하세요.

이름이 '하늘'인 사원

SELECT *
FROM emp
WHERE ename LIKE '%하늘';
내용을 입력하세요.

성과 이름이 각각 한 글자인 사원을 검색하세요
SELECT *
FROM emp
WHERE ename LIKE '__'; --언더바를 두개써줌으로써 이름과성이 한글자씩인 사원을 추출

내용을 입력하세요.

*BETWEEN 연산자


급여가 1000에서 2000이내인 사원

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000; --1000이상 2000이하
내용을 입력하세요.
-BETWEEN a AND b 를 사용해서 연산하면 a이상 b이하의 결과가 출력됨

-사용할때 a에 작은 조건을 넣어줘야 제대로 원하는 값이 도출된다. 큰값을 a에 넣게되면 큰값으로 한번

걸러져서 나온값이 b로 다시 걸러지는 것이기 때문에 원하는 값이 나오지 않을 수 있다.


1992년에서 1996년 사이에 입사한 사원을 검색하세요
-->'1992/01/01'=>'1992/01/01:00:00:00'
-->'1996/12/31'=>'1996/12/31:00:00:00'
--만약 1996년 12월 31일 11시 20분 30초에 입사한 사원은 검색이 되지 않는다 

SELECT *
FROM emp 
WHERE hdate BETWEEN '1992/01/01' AND '1996/12/31';
--시분초를 비교할 수 있는 포맷으로 변경한다 
ALTER SESSION SET nls_date_format = 'YYYY/MM/DD:HH24:MI:SS';--껏다킬때까지유효

SELECT *
FROM emp 
WHERE hdate BETWEEN '1992/01/01' AND '1996/12/31';
내용을 입력하세요.
-날짜를 이용할때 주의해야 한다. 그때는 포멧 변경을 해줘야 함


*IN 연산자


10번, 20번 부서 사원 
SELECT *
FROM emp 
WHERE dno IN ('10', '20') -﻿- 10번 20번중에 하나 속하는 칼럼을 추출
ORDER BY dno;

개발이나 회계 업무를 담당하는 사원
SELECT *
FROM emp 
WHERE job IN ('개발', '회계')
ORDER BY job;
내용을 입력하세요.
- 칼럼 IN (조건) : 조건에 맞는 칼럼들만 추출됨



﻿