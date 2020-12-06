
*트랜잭션(Transaction)

- 트랜잭션은 반드시 함께 실행되는 작업의 단위를 의미한다. 사용자의 의도에 따라 여러개의 문장으로 구성된

트랜잭션은 반드시 동시에 실행(COMMIT)되거나 취소(ROLLBACK)된다.RDBMS는 트랜잭션을 통해 작업

의 단위를 결정함으로써 작업 결과의 신뢰성을 확보한다.



*트랜잭션의 시작과 종료

1) 시작

- 이전 트랜잭션이 종료된 이후 DML(INSERT, UPDATE, DELETE)문장이나 DDL(CREATE, ALTER, DROP, TRUNCATE), DCL(GRANT, REVOKE)문장이 실행되었을 때 시작된다.


2) 종료

1. COMMIT 이나 ROLLBACK 명령이 실행될 때 종료된다.

2. DDL이나 DCL문장이 실행이 완료되면 자동으로 종료된다.

3. 사용자의 정상 종료시에 종료된다.

4. 데드락(DeadLock)이 걸리면 트랜잭션의 일부만 종료된다.


- 트랜잭션은 하나의 세션( 오라클 서버를 접속한 단위, 하나의 연결)에서 오로지 하나만 시작될 수 있다. DML인 경

우 반드시 COMMIT이나 ROLLBACK으로 종료한다. DDL이나 DCL은 오라클이 알아서 제어해준다.


*트랜잭션과 언두 세그먼트 (Undo Segment)

- DML작업에서 ROLLBACK 하기 위해서는 작업 이전 데이터를 가지고 있어야 한다. 그래서 이전의 데이터를

Undo tablesapce와 Undo Segment라는 물리적 구조에 저장한다. 위의 두가지는 트랜잭션에서만 사용되며

오라클에서 자동으로 관리하기 때문에 사용자들은 직접 정보를 볼 수 없다.


1. UPDATE 명령

2. 명령 수행을 위해 오라클이 Undo Segment를 결정

3. 테이블에 저장되있떤 원래값(5)이 Undo Segment에 저장

4. UPDATE 된 값(7)이 테이블에 저장

5. 값이 변경된 행(레코드)는 독점 잠금(LOCK)이 발생한다

6. 테이블에는 공유잠금(LOCK)이 발생한다

7-1. 트랜잭션이 COMMIT되면 잠금은 해제되고 변경된 값(7)은 영구히 저장된다

7-2. 트랜잭션이 ROLLBACK되면 Undo Segment에 저장했던 원래 값 (5)을 테이블로 환원하고 잠금이 해제된다



*잠금(LOCK)

- 데이터 베이스 관리에서 하나의 트랜잭션에 사용되는 데이터를 다른 트랜잭션이 접근하지 못하게 하는 것

- 데이터를 갱신할 때는 잠금(LOCK) - 실행(EXCUTE) -해제 (UNLOCK)의 규칙을 따라야한다

- 교착 상태 (Dead Lock) : 어떤 한 트랜잭션이 사용하기 위해 잠가놓은 자원을 사용하기 위해 기다리므로

모든 트랜잭션들이 실행을 전혀 진전시키지 못하고 무한정 기다리고 있는 상태



[세션 1]

--1) 관우, 장각 학생의 학과 정보를 검색한다
SELECT sno, sname, major
FROM student
WHERE sname IN ('관우', '장각'); --화학 화학

--2) 관우 학생의 학과를 경제로 변경시도한다
--   트랜잭션 시작
UPDATE student SET major='경제'
WHERE sname='관우';

--3) 변경이 잘 되었는지
--     관우, 장각 학생의 학과 정보를 검색한다
--     아직 트랜잭션이 완료되지 않은 상태
SELECT sno, sname, major
FROM student
WHERE sname IN ('관우', '장각'); --경제 화학

--8) 세션2가 장각의 트랜잭션을 진행중인 것을 모르고 
--   장각의 학과를 천문 학과로 변경을 시도
UPDATE student SET major='천문'
WHERE sname='장각';
--세션 2에서 장각 트랜젝션을 안끝내서 Script Runner 대기상태
--데드락이걸려도 계속 얘는 늦게 시작되서 무한대기 



세션2는 관우 학생의 변경을 시도했으므로 무한 대기상태였고 세션1은 세션2에 의해 트랜잭션이
진행중인 장각의 변경을 시도했으므로 동시에 무한 대기 상태로 빠져든다.
이렇게 2개의 세션모두 무한 대기상태에 빠져든 것을 DeadLock이라 부른다.

DeadLock은 세션 사용자에 의해 해결되지 않으므로 오라클은 먼저 무한 대기상태에 걸린 세션을 
오류 처리하고 강제로 마지막 명령만 ROLLBACK 함으로써 DeadLock을 해결한다
   
COMMIT;
   
   
내용을 입력하세요.

--[세션 2]

--4)  세션1에서 변경을 시도한 행을 포함한
--    관우, 장각 학생의 학과 정보를 검색한다
SELECT sno, sname, major
FROM student
WHERE sname IN ('관우', '장각');--화학 화학


--5) 장각 학생의 학과를 경제로 변경시도한다
UPDATE student SET major='경제'
WHERE sname='장각';

--6)  잘 적용되었는지
--    관우, 장각 학생의 학과 정보를 검색한다
SELECT sno, sname, major
FROM student
WHERE sname IN ('관우', '장각'); --화학 경제
--장각은 트랜젝션이 안걸려있어서 업데이트 가능 

--7) 관우 학생의 학과를 '물리'로 변경을 시도
--   현재 세션1에 의해 관우 학생의 행은 독점잠금이
--   걸려있는 상태이다.

UPDATE student SET major='물리'
WHERE sname='관우'; -- 데드락때문에 취소됨 


--세션1에서 관우 트랜젝션을 안끝내서 Script Runner 대기상태 
--세션1에서 장각 트랜젝션을 변경하려하면 먼저 무한대기가 걸린 쪽을
--오라클에서 강제로 풀어버림 (deadlock detected while waiting for resource)
--상대와 DeadLock상태에서 오라클의 에러 발생 후
--강제로 마지막 명령만 
--ROLLBACK 에 의해 무한 대기가 풀리게 된다.

SELECT sno, sname, major
FROM student
WHERE sname IN ('관우', '장각'); --화학 경제 
--마지막에 서로 맞물려서 물리와 천문으로 바꿀려던 명령은 실행되지 않았다 

COMMIT;--확정
내용을 입력하세요.
1)독점 잠금, 배타 잠금 (Exclusive Lock)

- 현재 세션이외에는 접근을 불허하는 잠금이다. 트랜잭션으로 행에 잠금이 발생하면 다른 세션에서는 해당 행을

검색할 수 없고 단지 Undo Segment의 정보만 보게 된다.

- 읽기나 기록 모두 불가능함

2)공유 잠금 (Share Lock)

- 이것은 DML 작업으로 행이 잠겨있는 테이블에 대해서 DDL (DROP, ALTER) 작업을 방지한다.

- 읽기만 가능하고 기록은 불가능함


﻿