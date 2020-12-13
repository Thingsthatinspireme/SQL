
*제약조건

- 제약조건이란 테이블 단위에서 데이터의 무결성을 보장해주는 규칙. 제약조건은 테이블에 데이터가 입력, 수정,

삭제시 또는 테이블이 삭제, 변경될 경우 잘못된 트랜젝션이 수행되지 않도록 결함을 유발할 가능성이 있는 작업

을 방지하는 역할을 수행한다.

- 특히 PK와 FK는 테이블의 필수 요소로서 관계성을 유지해주기 때문에 모든 테이블은 이들 둘 중 하나 이상을

반드시 포함하고 있다.


1) 테이블 단위에서 정의되고 적용된다.

2) 종속성이 존재하는 경우 테이블의 삭제를 막아준다.

자식 테이블이 있는 부모 테이블은 삭제가 불가하며 자식 테이블부터 삭제하고 부모 테이블을 삭제해야한다.

3) 자료가 삽입, 갱신, 삭제될 때마다 규칙이 적용된다.

4) 일시적으로 활성화하거나 비활성화 하는 것이 가능하다.

5) USER_CONTAINTS, USER_CONS_COLUMNS 딕셔너리에서 검색한다

6) 제약조건은 개체처럼 관리되므로 반드시 이름이 필요하다.


-PRIMARY KEY(PK) : 테이블에 반드시 지정해야 한다
-FOREIGN KEY(FK) : 자식 테이블은 반드시 지정해야 한다
-UNIQUE KEY(UK) : 유니크한 컬럼의 검색속도 향상 //내부적으로 인덱스가 생성이됨, 자주사용하는 키(중복되지 않음)
-NOT NULL       : PK는 무조건 NOT NULL, 타 컬럼 옵션
-CHECK          : 기타 조건
내용을 입력하세요.

*PK 설정

- 컬럼에 PK를 지정하는 방법은 아래처럼 2가지 방법이 있다.


﻿CREATE TABLE 테이블명 (
...
CONSTRAINT 제약조건이름 PRIMARY KEY (컬럼));
내용을 입력하세요.

CREATE TABLE 테이블명(
컬럼 데이터타입 CONSTRAINT 제약조건이름 PRIMARY;
내용을 입력하세요.
- 제약조건에 이름을 정의하지 않으면 오라클 서버가 자동으로 SYS_Cn형태의 이름을 붙여서 관리하기가 힘들어짐

그래서 관리자가 규칙성 있는 이름을 붙여주는 것이 훨씬 좋다.


--많이 사용되는 방법
CREATE TABLE dept(
  dno VARCHAR2(2),
  dname VARCHAR2(14),
  loc VARCHAR2(8),
  director VARCHAR2(4),
  CONSTRAINT dept_dno_pk PRIMARY KEY(dno)
 );
내용을 입력하세요.

--잘 사용되지 않는 방법
CREATE TABLE dept(
  dno VARCHAR2(2) CONSTRAINT dept_dno_pk PRIMARY KEY(dno)
  dname VARCHAR2(14),
  loc VARCHAR2(8),
  director VARCHAR2(4),
  );
내용을 입력하세요.
- 제일 많이 사용되는 방법은 테이블에 아무런 제약조건을 주지않고 생성한 후에 ALTER를 사용해서 제약조건을

따로 입력해주는 것이다. 데이터 입력할때 더 편하기 때문이다



*FK 설정


CREATE TABLE 테이블명(
...
CONSTRAINT 제약조건이름 FOREIGN KEY(컬럼)
REFERENCES 부모테이블 (참조컬럼) [ON DELETE CASCADE]);
내용을 입력하세요.

CREATE TABLE 테이블명(
컬럼명 데이터타입 CONSTRAINT 제약조건이름 FOREIGN KEY
                 REFERENCES 부모테이블 (참조컬럼)
                 [ON DELETE CASCADE],
...); 
내용을 입력하세요.
1) 부모 테이블을 참조하여 테이블을 생성할 때 FK를 정의한다

2) FK가 정의된 테이블이 자식(하위) 테이블이다

3) 참조되는 테이블을 부모(상위) 테이블이라고 한다

4) 부모 테이블은 미리 생성되어 있어야 한다

5) 부모 테이블의 참조되는 컬럼에 존재하는 값만을 입력할 수 있다.

6) 부모 테이블에 참조되는 행의 데이터는 FK를 위배하는 삭제나 변경이 불가능하다.

7) ON DELETE CASCADE : 참조되는 부모 테이블의 행에 대한 DELETE를 허용한다

(부모 테이블의 행을 삭제하면 참조하는 자식 테이블의 행도 함께 지워진다.)

8) 자료형이 반드시 부모테이블의 컬럼과 일치해야 한다.

9) 참조되는 컬럼은 PK거나 UK(Unique Key)만 가능하다

10) 외부키, 참조키, 외부식별자 등으로 불린다.

11) REFERENCES 'S'를 꼭 붙일것


CREATE TABLE emp(
 eno VARCHAR2(4),
 ename VARCHAR2(10),
 job VARCHAR2(6),
 mgr VARCHAR2(4),
 hdate DATE,
 sal NUMBER, --그냥 NUMBER만 주면 정수
 comm NUMBER,
 dno VARCHAR2(2),
 CONSTRAINT emp_eno_pk PRIMARY KEY (eno),
 CONSTRAINT emp_dno_fk FOREIGN KEY (dno)
 REFERENCES dept(dno)
);
내용을 입력하세요.

- PK로 정의된 dept의 dno, emp의 eno 컬럼은 중복된 값 X, NULL X

- FK로 정의된 emp의 dno는 dept의 dno를 참조하도록 설정했으므로,

emp에 데이터를 입력할 때 fk가 존재하지 않는 데이터를 입력하면 에러가 발생한다


--dept와 emp에 데이터를 입력하고 제약조건 설정을 테스트
INSERT INTO dept(dno, dname, loc)
 VALUES ('10', '개발', '서울');

--PK에 이미 '10'번 부서가 있으므로 중복데이터 입력 방지
--PK에 대한 무결성을 '개체 무결성'이라 한다
INSERT INTO dept(dno, dname, loc)
 VALUES ('10', '총무', '부산'); --오류발생 / 유일성을 가져야하는 조건이 위배됨 

--FK값이 부모테이블에 존재하지 않으므로 입력 방지
--FK에 대한 무결성을 '참조 무결성'이라 한다
INSERT INTO emp (eno, ename, dno)
 VALUES('2001', '손하늘', '20'); --오류발생 / 부모의 키가 발생될 수 없다 
 --지금 20번부서가 DEPT에 입력된게 없어서!
내용을 입력하세요.

*정규화를 하는 이유

- 데이터 무결성, 공간의 낭비방지를 위해서

- 의도적으로 하나로 합쳐논 경우는 읽어오는 속도를 빠르게 하기 위해서이다


*오라클에서 제공되는 제약조건 KEY


1) 테이블을 생성할 때 PK를 정의한다

2) PK는 각 행을 고유하게 식별하는 역할을 담당한다

3) 테이블당 하나 or 한개 그룹(복합키)만 정의 가능하다

4) 지정된 컬럼에는 중복된 값이나 NULL값이 입력불가하다

5) PK로 지정 가능한 컬럼이 여러개 있을 때에는 검색에 많이 사용되고 간단하고 짧은 컬럼을 지정한다

( ex) 사원 : 사번, 주민번호 ) 중에 사번을 선택

6) 주 식별자, 주키 등으로 불린다

7) 고유 인덱스 (Unique Index)가 자동으로 생성된다.



*제약조건을 정의하는 방법

- 테이블 생성 명령어 마지막에 기술하는 방법 : 테이블 레벨 정의

- 컬럼을 정의할 때 같이 정의하는 방법 : 컬럼 레벨 정의

- 둘중에 테이블 레벨 정의가 가독성이 높다


*데이터 모델링에서 물리 데이터베이스 테이블을 생성하는 방법


- ER-Win 툴에서 설정을 잘 선택, 제약조건이름 부여, 자동 생성 (툴을 잘 사용해야 함)

1) ERD(Entity Relation Diagram)

개념생략 → 매핑룰 → 정규화

논리모델링 → 정규화


- 모델링 (ERD) → 테이블 상세표 → 스크립트(*.sql)생성 → 실행 (현재는 이방법을 더 추천)

2) 테이블 상세표 - 제약조건 부여


위의 두가지를 가지고 있어야 한다는 원칙



*NOT NULL, UK, CHECK

1) PK, FK를 제외한 나머지 제약조건

2) 모든 테이블에 반드시 필요한 것은 아니지만 미리 프로세스상의 오류를 예방할 수 있다


*Unique Key 설정


﻿CREATE TABLE 테이블명(
...
CONSTRAINT 제약조건명 UNIQUE (컬럼)
);﻿
내용을 입력하세요.

CREATE TABLE 테이블명(
컬럼 데이터타입 
CONSTRAINT 제약조건명 UNIQUE,
...);
내용을 입력하세요.
1) UK(Unique Key)를 정의한다

2) 중복된 값을 허용하지 않지만 여러개의 NULL 은 허용한다

NULL 값은 비교가 불가능하므로 여러개라도 중복이 아니다.

3) 고유키라고도 불린다

4) 고유 인덱스(Unique Index)가 자동으로 생성된다.

5) 사원 테이블의 사번, 주민번호 중에 사번은 PK, 주민번호는 UK 설정을 한다.

유니크키는 조인해서 검색할때 쓸려고 많이 만들음


*NOT NULL 설정


﻿CREATE TABLE 테이블명(
컬럼 데이터타입 CONSTRAINT 제약조건명 NOT NULL,
... --null값이 들어가면 안된다
);﻿
내용을 입력하세요.
1) 컬럼 레벨 정의만 가능하다

2) 지정된 컬럼은 NULL 값을 허용하지 않는다

3) 반드시 NULL 값이 필요한 컬럼을 제외하고 가능한 모든 컬럼에 NULL 값을 허용하지 않는 것이 좋다.


*CHECK 설정


﻿CREATE TABLE 테이블명(
...
CONSTRAINT 제약조건명 CHECK(조건)
);﻿
내용을 입력하세요.

﻿CREATE TABLE 테이블명(
컬럼 데이터타입 CONSTRAINT 제약조건명 CHECK (조건),
...
);
내용을 입력하세요.
1) 행에 입력될 데이터의 조건을 정의한다

2) 조건은 WHERE 절에 기술하는 조건형식과 동일하다.

3) 어플리케이션에서 데이터의 조건을 체크하는 대신 테이블에서 조건을 체크하도록 하는 것이다.

(어플리케이션 코드양을 줄일 수 있다)




CREATE TABLE emp
 eno VARCHAR2(4),
 ename VARCHAR2(50) CONSTRAINT emp4_ename_nu NOT NULL,
 gno VARCHAR2(13),
 sex VARCHAR2(3),
 CONSTRAINT emp4_eno_pk PRIMARY KEY(eno),
 CONSTRAINT emp4_gno_uk UNIQUE(gno),
 CONSTRAINT emp4_gno_ch CHECK(LENGTH(gno) = 13), --gno의 길이가 13이 아니면 오류
 CONSTRAINT emp4_sex_ch CHECK(sex IN ('여', '남')) -- sex에 '여'와 '남'이 아니면 오류
);
내용을 입력하세요.

--정상 조건을 만족할 때 잘 입력됨
INSERT INTO emp4(eno, ename, gno, sex)
  VALUES ('1001', '김연아', '0602183123456', '여');

--NOT NULL 컬럼에 NULL 을 입력한 경우
INSERT INTO emp4(eno, ename, gno, sex)
  VALUES ('1002', null, '0602183123457', '남');--cannot insert NULL into 에러발생

--gno(주민번호) 중복시
INSERT INTO emp4(eno, ename, gno, sex)
  VALUES ('1003', '장나라', '0602183123456', '여'); --unique constraint violated 에러발생

--gno(주민번호) 글자수가 12글자 일때
INSERT INTO emp4(eno, ename, gno, sex)
  VALUES ('1005', '문근영', '060218312345', '여'); --check constraint violated 에러발생

--'여'/'남' 대신 'M'을 넣을 때
INSERT INTO emp4(eno, ename, gno, sex)
  VALUES ('1002', '임꺽정', '0602183123457', 'M'); --heck constraint violated 에러발생
내용을 입력하세요.

﻿