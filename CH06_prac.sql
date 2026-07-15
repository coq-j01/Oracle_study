-- 6강 되새김 문제 (4문제)
-- 1번 
-- 사원 이름 5~6글자인 사원 번호의 뒷자리 2개* 이름은 첫자리 대문자 제외 *로 출력
SELECT EMPNO,RPAD(SUBSTR(EMPNO,0,2),LENGTH(EMPNO),'*') AS MASKING_EMPNO
	,ENAME,RPAD(UPPER(SUBSTR(ENAME,0,1)),LENGTH(ENAME),'*') AS MASKING_ENAME
FROM EMP
WHERE LENGTH(ENAME)>=5 AND LENGTH(ENAME)<6; 

-- 2번
-- 평균 근무일 수 21.5 근무시간 8 시간일 때, 하루 급여와 시급 계산하여 출력
-- 하루 급여는 소수 3째에서 버리고 시급은 소수 2쨰자리에서 반올림
SELECT EMPNO, ENAME ,SAL,TRUNC(SAL / 21.5,2) AS DAY_PAY
	, ROUND(SAL / 21.5/ 8, 1) AS TIME_PAY 
FROM EMP;

-- 3번
-- 입사일 기준을 3개월이 지난 첫 월요일에 정직원이 됨 정직원 날짜를 출력
-- 추가수당 없는 직원 N/A로 출력
SELECT EMPNO, ENAME, TO_CHAR(HIREDATE,'YY/MM/DD'), TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월요일'),'YYYY-MM-DD')AS R_JOB
	,NVL(TO_CHAR(COMM),'N/A')
FROM EMP;

-- 4번
SELECT EMPNO, ENAME,MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(MGR,1,2) =75 THEN '5555'
		WHEN SUBSTR(MGR,1,2) =76 THEN '6666'
		WHEN SUBSTR(MGR,1,2) =77 THEN '7777'
		WHEN SUBSTR(MGR,1,2) =78 THEN '8888'
		ELSE TO_CHAR(MGR)
		END CHG_MGR
FROM EMP;

-- Oracle SQL 실습 문제 (20문제)

-- 문제 1 (AND)
-- 사원번호, 이름, 직무를 조회하시오.
-- 조건
-- 부서번호가 30
-- 급여가 1500 이상
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE SAL >= 1500
	AND DEPTNO = 30;

-- 문제 2 (OR)
-- 사원의 이름과 급여를 조회하시오.
-- 조건
-- 직무가 SALESMAN
-- 또는 직무가 CLERK
SELECT ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'CLERK';

-- 문제 3 (AND + OR)
-- 사원의 이름, 급여, 부서번호를 조회하시오.
-- 조건
-- 부서번호가 10 또는 20
-- 급여가 2000 이상
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO = 20
	AND SAL>=2000;

-- 문제 4 (LIKE)
-- 이름에 'A'가 포함된 사원의
-- 사원번호
-- 이름
-- 급여
-- 를 조회하시오.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE ENAME LIKE '%A%';

-- 문제 5 (LIKE)
-- 이름의 두 번째 글자가 'A'인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME LIKE '_A%';

-- 문제 6 (BETWEEN)
-- 급여가
-- 1000 이상
-- 3000 이하인
-- 사원의 이름과 급여를 조회하시오.
SELECT ENAME, SAL 
FROM EMP
WHERE SAL BETWEEN 1000 AND 3000;

-- 문제 7 (IN)
-- 부서번호가
-- 10
-- 20
-- 30
-- 중 하나인 사원의 이름과 부서번호를 조회하시오.
SELECT ENAME, EMPNO 
FROM EMP
WHERE DEPTNO IN (10,20,30);

-- 문제 8 (IS NULL)
-- 커미션(COMM)을 받지 않는 사원의
-- 이름
-- 급여
-- 커미션
-- 을 조회하시오.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM IS NULL ;

-- 문제 9 (IS NOT NULL)
-- 커미션을 받는 사원의 이름과 급여를 조회하시오.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE COMM IS NOT NULL;

-- 문제 10 (NOT)
-- 직무가 MANAGER가 아닌 사원을 조회하시오.
SELECT *
FROM EMP
WHERE JOB != 'MANAGER';

-- 문제 11 (UPPER)
--사원의 이름을 모두 대문자로 출력하시오.
--출력
-- 원래 이름
-- 대문자 이름
SELECT ENAME, UPPER(ENAME)
FROM EMP;

-- 문제 12 (LOWER, INITCAP)
-- 사원의 이름을
-- 소문자
-- 첫 글자만 대문자
-- 형태로 출력하시오.
SELECT ENAME, LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

-- 문제 13 (LENGTH)
-- 이름의 글자 수를 출력하시오.
-- 출력
-- 이름
-- 이름 길이
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 문제 14 (SUBSTR)
-- 사원의 이름 앞 3글자만 출력하시오.
SELECT ENAME, SUBSTR(ENAME,1,3)
FROM EMP;

--  문제 15 (ROUND, TRUNC)
-- 급여를
-- ROUND
-- TRUNC
-- 함수를 이용하여 출력하시오.
-- (소수 첫째 자리까지 표현)
SELECT SAL, ROUND(SAL,1), TRUNC(SAL,1)
FROM EMP;

-- 문제 16 (NVL)
-- 커미션이 NULL이면 0으로 출력하시오.
-- 출력
-- 이름
-- 커미션
-- NVL 결과
SELECT ENAME,COMM, NVL(COMM,0)
FROM EMP;

-- 문제 17 (CASE)
-- 급여에 따라 등급을 출력하시오.
-- 조건
-- 3000 이상 → HIGH
-- 2000 이상 → MIDDLE
-- 나머지 → LOW
-- 출력
-- 이름
-- 급여
-- 급여등급
SELECT ENAME, SAL,
	CASE
		WHEN SAL >=3000 THEN 'HIGH'
		WHEN SAL >=2000 THEN 'MIDDLE'
		ELSE 'LOW'
		END 급여등급
FROM EMP;

-- 날짜 함수 문제

-- 문제 18 (MONTHS_BETWEEN)
-- 현재 날짜 기준으로
-- 사원의 근무 개월 수를 조회하시오.
-- 출력
-- 이름
-- 입사일
-- 근무 개월 수
SELECT ENAME, HIREDATE , TRUNC(MONTHS_BETWEEN(SYSDATE , HIREDATE),0) AS 근무개월수
FROM EMP;

-- 집합 연산자 문제

-- 문제 19 (UNION)
-- 다음 두 결과를 하나의 결과로 출력하시오.
-- ① 급여가 3000 이상인 사원의 이름
-- ② 부서번호가 10인 사원의 이름
-- 중복은 제거한다.
SELECT ENAME
FROM EMP
WHERE SAL >= 3000
UNION
SELECT ENAME
FROM EMP
WHERE DEPTNO =10;


-- 문제 20 (INTERSECT, MINUS)
-- 다음을 각각 작성하시오.
-- ① 급여가 2000 이상인 사원 중 부서번호가 20인 사원
-- → INTERSECT 사용
SELECT *
FROM EMP
WHERE SAL >=2000
INTERSECT
SELECT *
FROM EMP
WHERE DEPTNO = 20;
-- ② 부서번호가 30인 사원 중 급여가 1500 이상인 사원을 제외한 나머지
-- → MINUS 사용
SELECT *
FROM EMP
WHERE DEPTNO = 30
MINUS
SELECT *
FROM EMP
WHERE SAL >=1500;


-- 추가 도전 문제 (실무형)

-- 도전 1
-- 이름이 'S'로 시작하고
-- 급여가 1000 이상이며
-- 커미션이 NULL인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%'
	AND SAL >=1000
	AND COMM IS NULL;

-- 도전 2
-- 급여 + 커미션(NULL은 0으로 계산)의 총 지급액을 출력하시오.
-- 출력
-- 이름
-- 급여
-- 커미션
-- 총 지급액
SELECT ENAME, SAL, COMM , SAL + NVL(COMM,0) AS 총지급액
FROM EMP;

-- 도전 3
-- 입사한 지 40년 이상 된 사원을 조회하시오.
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE , HIREDATE )>= 40*12;

-- 도전 4
-- SALGRADE 테이블을 이용하여
-- 급여가 2000~3000인 급여등급을 조회하시오.
SELECT GRADE  
FROM SALGRADE
WHERE LOSAL = 2001
	AND HISAL = 3000;

-- 도전 5
-- EMP와 DEPT를 이용하여
-- 부서명이 SALES인 사원의
-- 이름
-- 직무
-- 급여
-- 를 조회하시오.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO =(SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');

-- Oracle SQL 실습 문제 (중급)
-- SCOTT 계정 EMP 테이블 중심 (20문제)

-- 문제 1 (복합 조건)
-- 급여가 **1200 이상 3000 이하**이고 직무가 **MANAGER 또는 ANALYST**인 
-- 사원의 이름, 직무, 급여를 조회하시오.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL BETWEEN 1200 AND 3000
	AND JOB IN ('MANAGER','ANALYST');

-- 문제 2 (AND + NOT)
-- 부서번호가 30이면서 직무가 SALESMAN이 아닌 사원의 이름과 직무를 조회하시오.
SELECT ENAME, JOB 
FROM EMP
WHERE DEPTNO = 30
	AND JOB <> 'SALESMAN';

-- 문제 3 (IN + BETWEEN)
-- 부서번호가 **10 또는 20**이고 급여가 **1000~2500**인 사원의 정보를 조회하시오.
SELECT *
FROM EMP
WHERE DEPTNO IN (10 ,20)
	AND SAL BETWEEN 1000 AND 2500;

-- 문제 4 (LIKE)
-- 이름의 첫 글자가 **S**이고 마지막 글자가 **H**인 사원의 이름과 급여를 조회하시오.
SELECT ENAME, SAL
FROM EMP
WHERE ENAME LIKE 'S%H';

-- 문제 5 (LIKE)
-- 이름의 **세 번째 글자가 A**인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME LIKE '__A%';

-- 문제 6 (NOT LIKE)
-- 이름에 **A**가 포함되지 않는 사원의 이름과 직무를 조회하시오.
SELECT ENAME, JOB 
FROM EMP
WHERE ENAME NOT LIKE '%A%';

-- 문제 7 (IS NULL)
-- 커미션(COMM)이 없는 사원의 이름, 급여, 커미션을 조회하시오.
SELECT ENAME, SAL, COMM 
FROM EMP
WHERE COMM IS NULL;

-- 문제 8 (IS NOT NULL)
-- 커미션을 받는 사원의 이름, 급여, 커미션을 조회하시오.
SELECT ENAME, SAL, COMM 
FROM EMP
WHERE COMM IS NOT NULL;

-- 문제 9 (ORDER BY)
-- 급여가 1500 이상인 사원을 조회하시오.
-- 급여는 내림차순
-- 급여가 같으면 이름은 오름차순
-- 으로 출력하시오.
SELECT *
FROM EMP
WHERE SAL >= 1500
ORDER BY SAL DESC, ENAME;

-- 문제 10 (DISTINCT)
-- EMP 테이블에 존재하는 직무(Job)의 종류를 중복 없이 조회하시오.
SELECT DISTINCT JOB
FROM EMP;

-- Oracle 함수 문제

-- 문제 11 (UPPER, LOWER)
-- 사원의 이름을
-- 원래 이름
-- 대문자
-- 소문자
-- 형태로 출력하시오.
SELECT ENAME, UPPER(ENAME), LOWER(ENAME) 
FROM EMP;

-- 문제 12 (INITCAP)
-- 사원의 이름을 첫 글자만 대문자로 출력하시오.
SELECT INITCAP(ENAME)
FROM EMP;

-- 문제 13 (SUBSTR)
-- 이름에서
-- 앞 2글자
-- 가운데 2글자(2번째 문자부터)
-- 마지막 2글자
-- 를 출력하시오.
SELECT SUBSTR(ENAME,1,2),SUBSTR(ENAME,3,2),SUBSTR(ENAME,5)
FROM EMP;

-- 문제 14 (LENGTH)
-- 이름의 길이가 **4글자인 사원**만 조회하시오.
-- 출력
-- 이름
-- 이름 길이
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 문제 15 (INSTR)
-- 이름에 문자 **A**가 나타나는 위치를 출력하시오.
-- A가 없는 경우도 함께 출력하시오.
SELECT ENAME, INSTR(ENAME,'A')
FROM EMP;

-- 문제 16 (REPLACE)
-- 이름에 있는
-- 모든 **A**를 **@**로 변경하여 출력하시오.
SELECT ENAME, REPLACE(ENAME,'A','@')
FROM EMP;

-- 문제 17 (LPAD, RPAD)
-- 이름을
-- 왼쪽을 '*'로 채워 10자리
-- 오른쪽을 '*'로 채워 10자리
--형태로 출력하시오.
SELECT ENAME, LPAD(ENAME,10,'*'),RPAD(ENAME,10,'*')
FROM EMP;

-- 문제 18 (ROUND, TRUNC)
-- 급여를
-- ROUND(급여 × 1.15)
-- TRUNC(급여 × 1.15)
-- 결과를 각각 출력하시오.
SELECT SAL, ROUND(SAL * 1.15),TRUNC(SAL * 1.15)
FROM EMP;

-- 문제 19 (NVL + TO_CHAR)
-- 커미션이 NULL이면 0으로 표시하고,
-- 입사일은 YYYY/MM/DD
-- 형식으로 출력하시오.
-- 출력
-- 이름
-- 입사일
-- 커미션
SELECT ENAME, TO_CHAR(HIREDATE ,'YYYY/MM/DD'), NVL(COMM,0)
FROM EMP;

-- 문제 20 (CASE, DECODE)
-- 다음 두 가지를 모두 출력하시오.
--① CASE를 이용하여 급여 등급 출력
--| 급여      | 등급 |
--| ------- | -- |
--| 3000 이상 | A  |
--| 2000 이상 | B  |
--| 1000 이상 | C  |
--| 그 외     | D  |
--② DECODE를 이용하여 직무별 수당 출력
--
--| 직무       | 수당  |
--| -------- | --- |
--| MANAGER  | 500 |
--| ANALYST  | 400 |
--| SALESMAN | 300 |
--| 기타       | 100 |
--출력
-- 이름
-- 급여
-- 급여등급
-- 직무
-- 직무수당
SELECT ENAME,SAL,
	CASE 
		WHEN SAL >= 3000 THEN 'A'
		WHEN SAL >= 2000 THEN 'B'
		WHEN SAL >= 1000 THEN 'C'
		ELSE 'D'
	END
	,JOB
	, DECODE(JOB,
		'MANAGER', 500
		,'ANALYST', 400
		,'SALESMAN', 300
		,100
	),JOB,COMM
FROM EMP;

-- 심화 문제 (JOIN 없이 해결)

-- 심화 1
-- 급여를 10% 인상한 금액과 20% 인상한 금액을 각각 출력하시오.
SELECT SAL*1.1, SAL*1.2
FROM EMP;

-- 심화 2 왜틀린건데ㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜㅠㅜ
--입사일을 다음과 같이 출력하시오.
-- 1981년 02월 20일 (금요일)
-- (Hint : `TO_CHAR`의 날짜 형식 사용)
SELECT TO_CHAR(HIREDATE,'YYYY"년" MM"월" DD"일" (DAY)')
FROM EMP;

-- 심화 3
-- 이름이 5글자 이상이고 급여가 1500 이상이며 커미션이 없는 사원을 조회하시오.
SELECT *
FROM EMP
WHERE LENGTH(ENAME)>=5 
	AND SAL >=1500
	AND COMM IS NULL;

-- 심화 4
-- 이름의 첫 글자가 M 또는 J이고 마지막 글자가 S인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME LIKE 'M%S' OR ENAME LIKE 'J%S'

-- 심화 5
-- 다음을 집합 연산자로 각각 작성하시오.
-- UNION
-- UNION ALL
-- INTERSECT
-- MINUS
-- 급여가 2000 이상인 사원
-- 부서번호가 10인 사원
SELECT *
FROM EMP
WHERE SAL >= 2000
UNION
SELECT *
FROM EMP
WHERE DEPTNO =10;

SELECT *
FROM EMP
WHERE SAL >= 2000
UNION ALL
SELECT *
FROM EMP
WHERE DEPTNO =10;

SELECT *
FROM EMP
WHERE SAL >= 2000
MINUS
SELECT *
FROM EMP
WHERE DEPTNO =10;

SELECT *
FROM EMP
WHERE SAL >= 2000
INTERSECT
SELECT *
FROM EMP
WHERE DEPTNO =10;