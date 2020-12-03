
*단일 행 함수

- 데이터를 프로그램에서 가공 처리하는 것보다, DBMS에서 처리해 결과만 받아서 사용하는 것이 효율적이다

- 아키텍쳐 면에서 프로그램은 받아온 결과를 보여주는데 주력하고, DBMS는 데이터를 저장하고 처리하는데만

집중하면 역할의 분리가 확실하게 이루어지므로 유연성이 증대된다 (프로그램과 DBMS가 느슨한 연결이 되어

변경, 유지보수에 유리해진다.)



*문자함수


-UPPER : 문자열을 대문자로 변환


ERP 부서가 있는 지역을 검색한다

SELECT loc "ERP 부서지역", dname 
FROM dept
WHERE UPPER(dname) = 'ERP'; --dname에 입력되어있는 ERP를 대문자로 바꿔줌
내용을 입력하세요.

-LOWER : 문자열을 소문자로 변환


SELECT loc "ERP 부서지역", dname 
FROM dept
WHERE LOWER(dname) = 'erp'; --dname에 입력되있는 erp를 소문자로 바꿔줌
내용을 입력하세요.

-INITCAP : 첫문자만 대문자로 변환, 나머지는 소문자로 변환


SELECT loc "ERP 부서지역", dname 
FROM dept
WHERE INITCAP(dname) = 'Erp'; --dname에 입력된 ERP를 첫문자를 대문자로 나머지를 소문자로
내용을 입력하세요.

*문자 연산 함수


-SUBSTR : 문자열 내에 지정된 위치의 문자열을 반환한다. (문자열, 위치, 갯수)

SUBSTR('oracle', 1, 2) => or


SUBSTR함수를 이용해서 컬럼에 일부 내용만을 검색한다

SELECT ename, SUBSTR(ename, 2), -- 2번째 글자부터
              SUBSTR(ename, -2), -- 뒤에서 2번째 글자부터
              SUBSTR(ename, 1, 2), -- 1번째 글자부터 2글자
              SUBSTR(ename, -2, 2) -- 뒤에서 2번째 글자부터 2글자
FROM emp;
내용을 입력하세요.
-LENGTH : 문자열의 길이를 반환

LENGTH('oracle') => 6


부서명과 길이를 출력하라

SELECT dname, LENGTH(dname)
FROM dept;

부서명의 마지막 글자를 제외하고 검색한다
SELECT dno, SUBSTR(dname, 1, LENGTH(dname)-1)--dname을 1부터 dname의 길이보다 1작을 때까지 검색
FROM dept;
내용을 입력하세요.

-INSTR : 지정된 문자의 위치를 리턴

INSTR('oracle', 'a') => 3


SELECT INSTR('database', 'a'),-- 처음부터 (2)
       INSTR('database', 'a' ,3),-- 3번째 자리이후 a가 보이는 위치 (4)
       INSTR('database', 'a' ,1,3)-- 1번째 자리이후 a가 3번째 보이는 위치 (6)
FROM dual;
내용을 입력하세요.

-TRIM : 접두어나 접미어를 잘라낸다

TRIM('o' FROM 'oracle') => racle / oracle 로부터 o를 잘라내라

-TRIM은 주로 공백 문자를 제거하는데 사용된다. 이름을 입력할때 '홍길동'과같이 입력되지 않고

' 홍길동', '홍길동 ' 과같이 앞뒤로 공백이 입력되는 경우가 있는데 이때 ename = '홍길동'으로 검색 조건을

설정하면 출력이 되지않는다. 그때 TRIM(ename)을 사용하면 앞뒤의 공백 문자가 제거된다.


SELECT TRIM('남' from '남기남'), -- 기
       TRIM(leading '남' from '남기남'), -- 기남
       TRIM(trailing '남' from '남기남'), -- 남기
       TRIM(leading '남' from '남남남기남남남남') --기남남남남
FROM dual;
내용을 입력하세요.

-LPAD, RPAD : 지정된 문자열의 길이만큼 빈부분에 문자를 채운다

LPAD('20000', 10, *) => *****20000

RPAD('20000', 10, *) => 20000*****


이름과 급여를 각각 10컬럼으로 검색한다

SELECT eno, RPAD(ename, 10, '*'), --오른쪽에 *
            LPAD(sal, 10, '*')  --왼쪽에 *
FROM emp;
내용을 입력하세요.

*문자 치환 함수

- TRANSLATE : 문자 단위로 치환된 값을 리턴한다

TRANSLATE('oracle', 'o', '#') => #racle


- REPLACE : 문자열단위 치환된 값을 리턴한다 (더 많이 사용된다)

REPLACE('oracle' , 'or', '##') => ##acle


SELECT TRANSLATE('World of Warcraft', 'Wo', '-*') Translate,
       --'Wo'는 '-*'로 'w'는 '-'로 'o''*'로 치환되서 나오게됨  
       REPLACE ('World of Warcraft', 'Wo', '--') Replace
       --'Wo'가 '--'로 치환되서 나옴 
FROM dual;
내용을 입력하세요.

*단일 행 함수 -숫자, 날짜형 함수



-ROUND : 반올림해주는 함수이다, 소숫점자리를 정해주지 않는다면 정수를 기준으로 출력된다.

ROUND(m, n) -- n의 자리까지 반올림을 한다,

ROUND(1234567, -3) =>1235000 -- n에 마이너스를 넣으면 정수의 자리에서 반올림 됨.

ROUND(123.4567, 3) => 123.457


-TRUNC : TRUNC (m, n) n자리 미만을 절삭한다. (n의 값에 -를 주게되면 정수자리로 올라가서 절삭)

TRUNC (123.4567, 3) =>123.456 / TRUNC(19786.786, -2) => 19700


SELECT ROUND(98.765), TRUNC(98.765), -- 소숫점자리를 지정해주지 않으면 정수를 기준으로 출력
       ROUND(98.765, 2), TRUNC(98.765, 2)
FROM dual;
내용을 입력하세요.
-MOD : MOD(m, n) m을 n으로 나눈 나머지를 계산해준다

MOD(10, 4) => 2


SELECT MOD(19, 3), MOD(-19, 3)
FROM dual;
내용을 입력하세요.
-POWER : POWER (m, n) m의 n승을 계산해준다

POWER(2, 4) => 16


-CEIL : CEIL(m) m보다 큰 가장 작은 정수를 찾아준다

CEIL(2.34) => 3


-FLOOR : FLOOR(m) m보다 작은 가장 큰 수를 찾는다

FLOOR(2.34) => 2


-ABS : ABS (m) m의 절대값을 계산한다

ABS(-4) => 4


-SQRT : SQRT(m) m의 제곱근을 계산한다

SQRT(9) => 3


-SIGN : SIGN (m)/ 부호 m이 음수면 -1, 양수면 1, 0이면 0을 반환한다

SIGN(-3) => -1


*날짜 함수


SELECT sysdate 
FROM dual;
내용을 입력하세요.
-오늘 날짜를 출력해주는 함수


ALTER SESSION SET nls_date_format='YYYY/MM/DD:HH24:MI:SS';
내용을 입력하세요.
-변경된 포멧대로 출력됨


ALTER SESSION SET nls_date_format='YYYY/MM/DD';
내용을 입력하세요.
-다시 원래설정으로 바꿔주는 포멧



*날짜의 계산


- 날짜 + 숫자 = 날짜 (일수 이후 날짜)


- 날짜 - 숫자 = 날짜 (일수 이전 날짜)


- 날짜 + 숫자/24 = 날짜 (시간을 더한 날짜)


SELECT sysdate + 48/24 --오늘 날짜에서 48시간을 더한 날짜가 나옴  
FROM dual;
내용을 입력하세요.
- 날짜 - 날짜 = 숫자 (두 날짜 간에 차(일수))


- 날짜 함수는 주로 회계 정산시 많이 사용한다 (ERP 솔루션이나 SI회계)


-ROUND : ROUND(날짜, 형식) 형식에 맞추어 반올림한 날짜를 반환한다.


SELECT sysdate, ROUND(sysdate, 'YY') 년, --년을 반올림
        ROUND(sysdate, 'MM') 월, --월을 반올림
        ROUND(sysdate, 'DD') 일 --일을 반올림
FROM dual;
내용을 입력하세요.
-TRUNC : TRUNC (날짜, 형식) 형식에 맞추어 절삭한 날짜를 반환한다.


SELECT sysdate, TRUNC(sysdate, 'YY') 년,
                TRUNC(sysdate, 'MM') 월,
                TRUNC(sysdate, 'DD') 일
FROM dual;
내용을 입력하세요.

SELECT TRUNC(sysdate, 'DD') - TRUNC(hdate, 'DD')+1 "일한 날"
FROM emp 
WHERE ename = '김연아';
내용을 입력하세요.
-MONTHS_BETWEEN : MONTHS_ BETWEEN(날짜1, 날짜2) 두 날짜간의 기간을 월 수로 계산한다


SELECT eno, ename, TRUNC(MONTHS_BETWEEN(sysdate, hdate)) 근무개월 --소숫점자리 때문에 TRUNC사용
FROM emp
WHERE dno = '20';
내용을 입력하세요.
-ADD_MONTH : ADD_MONTH(날짜, n) 날짜에 n달을 더한 날짜를 계산한다


SELECT eno, ename,  hdate 입사일,
      hdate + 99 "입사 100일째", --입사당일이 1일이라서 
      ADD_MONTHS(hdate, 10*12) "입사 10년째 되는 날"
FROM emp
WHERE dno = '20';
내용을 입력하세요.
-NEXT_DAY : NEXT_DAY (날짜, 요일) 날짜이후 지정된 요일에 해당하는 날짜를 계산해준다.

요일은 'sun', '일요일', 1 (일요일) 과 같이 다양한 표현이 가능하다.


SELECT NEXT_DAY('1994-01-17', 1) --94/01/23 출력 
FROM dual;
내용을 입력하세요.
-LAST_DAY : LAST_DAY(날짜)

날짜를 포함한 달의 마지막 날짜를 계산



SELECT eno, ename, hdate, LAST_DAY(hdate) "입사한 달 마지막 날짜",
       LAST_DAY(TRUNC((hdate))-TRUNC(hdate) "입사한 달 근무일수"
FROM emp
WHERE dno = '20';
내용을 입력하세요.

*날짜 출력 형식


-YYYY : 년도

-YY : 두자리로 표현된 년도 (99년은 2099를 의미)

-RR : 두자리로 표현된 년도이지만 현재 년도와 가까운 년도를 사용한다 (99년은 1999년을 의미)

-MM : 두자리 숫자로 표현된 월 (03)

-MONTH : 영문이나 한글로 표현된 월 (MARCH, 3월)

-MON : 약자로 표현된 영문 및 한글 월 (MAR, 3월)

-DD : 일 (01)

-DAY : 영문이나 한글 요일 (SUNDAY , 일요일)

-DY : 약자로 표현된 요일 (SUN, 일)

-HH24 : 1-24시로 표현

-HH : 1-12시로 표현 AM/PM을 추가하는것이 정확하다

-MI : 두자리 분

-SS : 두자리 초

-SSSS : 하루를 초로 환산한 다음 표현 (0-86399)

-오전/오후 AM/PM : 오전 오후 표기



*숫자 출력 형식


-9 : 숫자의 출력 폭지정(자리수가 부족하면 생략)


SELECT TO_CHAR(12345.678, '999,999.99999') 숫자 --소숫점위로 6자리 소숫점아래로 5자리 출력형식을 표현
FROM dual;                                     --9는 자리표기를 위한 포멧

SELECT TO_CHAR(12345.678, '099,999.999') 숫자
FROM dual;

SELECT TO_CHAR(12345.678, '9,9999.9') 숫자 --소숫점 첫째자리에서 반올림됨
FROM dual;                                --콤마도 천의자리에 된게 아니라 만의자리에 출력
            
SELECT TO_CHAR(12345.678, '9,999.9') 숫자 --소수점 앞자리가 부족하면 출력장애가 발생한다
FROM dual;
내용을 입력하세요.

-0 : 선행 0표기(자리수를 반드시 맞춘다)

-$ ; 화폐 표기(달러)

-L: 지역 화폐 표기(각 국가 코드에 따라 다르다) --로컬 지역화폐

-, : 쉼표 위치 지정

-. : 마침표 위치 지정

-MI : 음수의 -기호를 오른쪽에 표기


SELECT TO_CHAR(-1234, '999,999MI') 숫자 --음수의 기호를 오른쪽에다 표기 -- 1,234-
FROM dual;
내용을 입력하세요.
-EEEE : 실수 표현법을 이용



*변환 함수

-TO_CHAR : 날짜나 숫자를 문자로 변환후 출력 형식을 지정

TO_CHAR(날짜, 출력형식), TO_CHAR(숫자, 출력형식)


-TO_DATE : 데이터를 날짜형으로 해석한다

TO_DATE(문자, 해석형식)

TO_DATE로 작성된 SQL문은 어떤 오라클 환경에서도 동일한 사용이 보장된다.

이럴때 '이식성이 좋다' 라고 표현한다. TO_DATE가 문자로 표현된 년원일 형식을 DATE형으로 바꿔

주기 때문에 DATE형과 비교가 가능해지므로 사용하기 편하다.


SELECT eno, ename, hdate
FROM emp
WHERE hdate < TO_DATE('1992/01/01', 'YYYY/MM/DD');
     --문자열을 DATE형으로 바꿔서 비교해줄 수 있다.
내용을 입력하세요.
-TO_NUMBER : 데이터를 숫자로 해석한다. 대부분의 경우 오라클의 자동 형변환에 의해 숫자로 읽을 수 있는

문자는 자동 변환되서 잘 사용하지 않는다. SQL 보다 PL-SQL에서 가끔 사용한다

﻿