
*테이블(Table)

- DB에서 데이터를 저장하는 가장 기본적인 구조

- 오라클에는 테이블외에 뷰(View), 인덱스(Index), 시퀀스(Sequence)등 여러 개체가 있고 이들 중에

물리적인 공간을 갖는 개체를 세그먼트(Segment)라고 분류한다. 이들 중 테이블은 사용자가 직접 조회

가능한 데이터를 저장하는 유일한 세그먼트이다.

- DB를 테이블 관점에서 보면, DB란 테이블에 저장된 데이터의 효율성과 무결성을 보장하기 위한

시스템으로 이해할 수 있다 →관계형 데이터 베이스의 특징( 정형화된 정보를 집어넣어 검색이 더 빨라지게 함)


*테이블 생성과 삭제

- 테이블은 행(Row)과 열(Column)으로 이루어진 자료구조

1)CREATE TABLE 테이블명 (

컬럼명, 데이터타입 [DEFAULT 디폴트값] [컬럼 레벨 제약조건],

컬럼명, 데이터타입 [DEFAULT 디폴트값] [컬럼 레벨 제약조건]);


- 데이터 타입 : 컬럼에 입력될 데이터의 종류와 크기를 결정한다 (자료형)

- DEFAULT :입력이 누락되었을 때 기본 입력값을 정의한다

- 컬럼 레벨 제약조건 : PK, FK, UK, CHECK, NOT NULL등을 지정한다

- 테이블 레벨 제약조건 : PK, FK, UK, CHECK 만 지정한다, NOT NULL은 정의할 수 없다.



*DROP TABLE 테이블명

[CASCADE CONSTRAINT];


- 테이블을 삭제

- CASCADE CONSTRAINT : 테이블이 다른 테이블로부터 참조되는 경우 해당 제약조건을 먼저 삭제한 후 테이블

삭제


DROP TABLE t1;
내용을 입력하세요.

DROP USER bitjava CASCADE;
내용을 입력하세요.


*SELECT table_name, column_name,

data_type, data_length

FROM user_tab_columns

WHERE table_name = 테이블명;


-테이블 이름을 반드시 대문자로 입력한다

-user_tab_columns 데이터 딕셔너리 (Data Dictionary) 를 통해서 지정한 테이블의 구조를 자세히 검색

- data_type : 컬럼의 데이터 타입

- data_length : 컬럼의 길이


SELECT table_name, column_name, 
       data_type, data_length
FROM user_tab_columns
WHERE table_name = 'BOARD';
내용을 입력하세요.

*테이블을 생성할 때 이름 규칙

- 문자로 시작

- 30자 이내로 설정

- 영문, 숫자, _, $, #만을 사용한다

- 한글은 사용가능하지만 되도록 안쓴다(코드 오류때문에 )

- 테이블은 동일한 유저(스키마, 계정)안에서 유일해야 한다

- 예약어 (명령어 등)은 사용이 불가능하다

- 대소문자를 구별하지 않는다 (생성할 때 사용한 문자와는 관계없이 모든 이름은 대문자로 저장된다)


*데이터 타입

- 문자 타입 : CHAR(고정길이 문자), VARCHAR2, LONG, CLOB

- 숫자 타입 : NUMBER

- 날짜 타입 : DATE

- 이진타입 : RAW, LONG RAW, BLOB, BFILE

- ROWID 타입 : ROWID



0열 선택0열 다음에 열 추가
1열 선택1열 다음에 열 추가
0행 선택0행 다음에 행 추가
1행 선택1행 다음에 행 추가
2행 선택2행 다음에 행 추가
3행 선택3행 다음에 행 추가
4행 선택4행 다음에 행 추가
5행 선택5행 다음에 행 추가
6행 선택6행 다음에 행 추가
7행 선택7행 다음에 행 추가
8행 선택8행 다음에 행 추가
9행 선택9행 다음에 행 추가
셀 전체 선택
열 너비 조절
행 높이 조절
VARCHAR2(n)

가변길이 문자타입

(1 < n < 4000 byte) :한글은 UT8로하면 한글자에 3byte라서 1300글자정도 입력가능)

CHAR(n)

고정길이 문자타입 (주어진 문자길이만큼 못채워도 그용량만큼 소모)

(1 < n < 4000 byte)

NUMBER(n, p)

숫자 타입 , n은 전체 자리수, p는 소수점 이하 자리수, 전체 자리수를 초과할 경우는 입력거부되지만 소수점 이하자리수가 초과되면 반올림입력, 소수점 이하의 값이 없는 경우는 길이를 지정하지 않는 것이 좋다

DATE

날짜 타입, 출력이나 입력 형식과 무관하게 YYYY/MM/DD:HH24:MI:SS 형태로 저장된다. (기원전 4712년 1월 1일 ~ 서기 9999년 12월 31일)

LONG

2GB까지 저장 가능한 가변길이 문자 타입 단 조건 검색할 수 없다.

테이블에는 하나의 LONG 컬럼만 정의할 수 있다. 대신 CLOB 를 사용한다

CLOB

LONG 를 개선한 타입 최대 4G까지 저장 가능하고 한 테이블의 여러 컬럼에 정의할 수 있다.(잘 안씀)

BLOB

4G까지 저장 가능한 가변길이 이진 타입 (4G까지 문자를 저장 할 수 있음)

ROW(n)

가변길이 이진타입(n < 2000)

BFILE

외부 파일저장을 위한 이진 타입. 4G 이내 파일을 저장한다

ROWID

ROWID 를 저장하기 위한 데이터 타입. 주로 PL-SQL 프로그래밍에서 많이 사용되며

각 문자는 64진수로 Encoding 되어있다.

셀 병합
행 분할
열 분할
너비 맞춤
삭제
-VARCHAR2(문자), NUMBER(숫자 : 실수와 정수 다 가능), DATE 이 3가지 자료형이 99%이상 사용된다.


--테이블을 생성하자
--테이블명 : board
--컬럼 구성 : no(게시물 번호)
--           name(작성자)
--           sub(제목)
--           content(내용)
--           hdate(입력일시)

CREATE TABLE board(
  no  NUMBER,
  name VARCHAR2(50),
  sub VARCHAR2(100),
  content VARCHAR2(4000),
  hdate DATE DEFAULT sysdate --default 값으로 현재시간 입력해줘서 따로 시간주지 않으면 현재시간이 입력
); --DDL이라서 트랜젝션이 내부에서 저절로 완료되었음 
내용을 입력하세요.

--테이블을 생성하고 데이터를 입력 확인한다
CREATE TABLE t1(
  no NUMBER(4,2)
);

INSERT INTO t1 VALUES (12.12);
INSERT INTO t1 VALUES (1.789);

SELECT * FROM t1;

INSERT INTO t1 VALUES (123.1); 
-- 위에 NUMBER 조건에 (4, 2)로 되어있어서 
--전체 4자리중 소수점은 2자리로 설정되있어서 
--소수점이 1자리인 숫자는 입력불가 
내용을 입력하세요.

CREATE TABLE t2(
  name VARCHAR2(3)
);


INSERT INTO t2 VALUES ('AAA');
INSERT INTO t2 VALUES('장');
INSERT INTO t2 VALUES('장강'); --위에 VARCHAR2(3)로 설정되어있는데 UTF8에서 한글 1글자에 3byte여서 두글자면 6byte라 입력불가
INSERT INTO t2 VALUES ('A');
내용을 입력하세요.

CREATE TABLE comp(
  co1 CHAR(4),
  co2 VARCHAR2(4)
);

INSERT INTO comp VALUES('AA', 'AA'); --4byte, 2byte(VARCHAR2라서 입력한값만 메모리차지)
INSERT INTO comp VALUES('AAAA', 'AAAA');--4byte,  4byte
SELECT * FROM comp;

SELECT * FROM comp WHERE co1='AA';
SELECT * FROM comp WHERE co2='AA';
SELECT * FROM comp WHERE co1=co2;--'AAAA','AAAA'만 용량이 같아서 이줄만 같다고 출력됨 

--아래 2개는 서로 다른 데이터로 판단한다
--co1 CHAR(4)     'AA'   AA__
--co2 VARCHAR2(4) 'AA'   AA
--CHAR 를 쓰지 않고 VARCHAR2 를 사용하면 된다
내용을 입력하세요.

--DATE 타입
CREATE TABLE hd(
  no NUMBER,
  hdate DATE
);

INSERT INTO hd VALUES (1, sysdate);
SELECT * FROM hd;

--연월일은 같지만 시분초가 다르므로 검색되지 않는다
SELECT *
FROM hd
WHERE hdate='2020/12/03';

--범위 검색을 해야 한다
SELECT *
FROM hd
WHERE hdate BETWEEN '2020/12/03' AND '2020/12/04';

SELECT *
FROM hd
WHERE hdate >= '2020/12/03' AND hdate < '2020/12/04'; --더 정확
내용을 입력하세요.
- 우리나라에서는 날짜는 DATE보다 VARCHAR2(8)로 정의하는 경우가 많다. 이형식은 시분초를 사용할 수 없다

- 외국에서는 TRUNC(sysdate) 시분초를 항상 00:00:00이 되게 저장한다.

- sysdate를 사용하면 범위검색을 사용해야 한다 : 시분초를 00:00:00으로 지정해줘야만 년월일이 맞는 경우를 도출 할 수 있다.

﻿