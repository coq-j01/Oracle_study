-- GPT 문제
-- 문제 1 (GROUP BY)
-- 부서별 사원 수를 조회하시오.
-- 출력
-- 부서번호
-- 사원 수
SELECT DEPTNO AS 부서번호 ,COUNT(*) AS 사원수
FROM EMP
GROUP BY DEPTNO;

-- 문제 2 (GROUP BY)
-- 직무별 평균 급여를 조회하시오.
-- 출력
-- 직무
-- 평균 급여
SELECT JOB, ROUND(AVG(SAL)) AS AVG_SAL
FROM EMP e 
GROUP BY JOB;

-- 문제 3 (GROUP BY)
-- 부서별
-- 최고 급여
-- 최저 급여
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP e 
GROUP BY DEPTNO;

-- 문제 4 (HAVING)
-- 직무별 평균 급여를 조회하시오.
-- 단,
-- 평균 급여가 **2000 이상인 직무만** 출력하시오.
SELECT JOB, TRUNC(AVG(SAL)) AS AVG_SAL
FROM EMP e 
GROUP BY JOB
HAVING AVG(SAL) >= 2000;

-- 문제 5 (기본 JOIN)
-- EMP와 DEPT를 이용하여
-- 다음을 조회하시오.
-- 사원명
-- 부서명
SELECT ENAME, DNAME
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO); 

-- 문제 6 (JOIN)
-- 사원명
-- 직무
-- 부서명
-- 근무지
-- 를 조회하시오.
SELECT ENAME, JOB, d.DNAME  , LOC
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO); 

-- 문제 7 (JOIN + ORDER BY)
-- 부서명이 **SALES**인 사원의
-- 이름
-- 직무
-- 급여
-- 를 조회하시오.
-- 급여가 높은 순으로 출력하시오.
SELECT ENAME,JOB,SAL
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO)
WHERE DNAME = 'SALES'
ORDER BY SAL DESC; 

-- 문제 8 (GROUP BY)
-- 부서별
-- 평균 급여
-- 최고 급여
-- 최저 급여
-- 총 급여
-- 를 조회하시오.
SELECT DEPTNO, ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP e 
GROUP BY DEPTNO;

-- 문제 9 (GROUP BY + HAVING)
-- 부서별 평균 급여를 조회하시오.
-- 평균 급여가
-- 2500 이상인 부서만** 출력하시오.
SELECT DEPTNO
FROM EMP e 
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2500;

-- 문제 10 (JOIN + GROUP BY)
-- 부서명별
-- 사원 수를 조회하시오.
-- 출력
-- 부서명
-- 사원 수
SELECT DNAME, COUNT(*) AS 사원수
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO)
GROUP BY DNAME;

-- 문제 11 (JOIN + GROUP BY)
-- 부서명별 평균 급여를 조회하시오.
SELECT DNAME, ROUND(AVG(SAL)) AS 평균급여
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO)
GROUP BY DNAME;

-- 문제 12 (비등가 JOIN)
-- EMP와 SALGRADE를 이용하여
-- 다음을 출력하시오.
-- 이름
-- 급여
-- 급여등급(GRADE)
SELECT ENAME, SAL , S.GRADE 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 문제 13 (JOIN + GROUP BY + HAVING)
-- 부서별 평균 급여를 조회하시오.
-- 단,
-- 사원이 **3명 이상인 부서만** 출력하시오.
SELECT DEPTNO,COUNT(*), ROUND(AVG(SAL))
FROM EMP e 
GROUP BY DEPTNO
HAVING COUNT(*)>=3;

-- 문제 14 (SELF JOIN)
-- 사원과 관리자 이름을 함께 출력하시오.
-- 출력
-- 사원
-- 관리자
SELECT E.ENAME AS 사원, M.ENAME AS 관리자
FROM EMP E JOIN EMP M ON(E.MGR = M.EMPNO);

-- 문제 15 (SELF JOIN)
-- 관리자가 없는 사원을 조회하시오.
SELECT E.ENAME , M.EMPNO 
FROM EMP E LEFT OUTER JOIN EMP M ON(E.MGR = M.EMPNO)
WHERE M.EMPNO IS NULL;

-- 문제 16 (3개 테이블 JOIN)
-- EMP
-- DEPT
-- SALGRADE
-- 세 테이블을 이용하여
-- 다음을 조회하시오.
-- 사원명
-- 부서명
-- 급여
-- 급여등급
-- 근무지
SELECT ENAME, DNAME, SAL, GRADE, LOC
FROM EMP E, DEPT D, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND D.DEPTNO = E.DEPTNO ;

-- 문제 17 (JOIN + GROUP BY)
-- 직무별
-- 부서별
-- 평균 급여를 조회하시오.
-- 출력
-- 부서명
-- 직무
-- 평균 급여
SELECT DNAME, JOB, ROUND(AVG(SAL)) AS 평균급여
FROM EMP e JOIN DEPT d ON(E.DEPTNO = D.DEPTNO)
GROUP BY DNAME, e.JOB
ORDER BY DNAME, e.JOB;

-- 문제 18 (JOIN + GROUP BY + HAVING)
--부서별 총 급여를 조회하시오.
-- 단,
-- 총 급여가 **9000 이상인 부서만** 출력하시오.
SELECT E.DEPTNO, DNAME, SUM(SAL)
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
GROUP BY E.DEPTNO , DNAME 
HAVING SUM(SAL) >= 9000;

-- 문제 19 (JOIN + GROUP BY + HAVING)
-- 급여등급(SALGRADE)별
-- 사원 수와 평균 급여를 조회하시오.
-- 단,
-- 평균 급여가 **2000 이상인 등급만** 출력하시오.
SELECT GRADE, COUNT(*) AS 사원수, ROUND(AVG(SAL))
FROM EMP E, DEPT D, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY GRADE
HAVING AVG(SAL) >= 2000;

-- 문제 20 (SELF JOIN + GROUP BY)
-- 관리자별
-- 관리하는 사원 수를 조회하시오.
-- 출력
-- 관리자 이름
-- 부하 직원 수
SELECT  M.EMPNO, M.ENAME , COUNT(*) AS 부하직원수
FROM EMP E JOIN EMP M ON(E.MGR = M.EMPNO)
GROUP BY M.EMPNO, M.ENAME;
