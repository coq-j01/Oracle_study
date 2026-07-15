-- GPT 문제
-- 문제 1
-- SCOTT보다 급여가 많은 사원을 조회하시오.
-- 출력
--사원번호
--이름
--급여
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');

-- 문제 2
-- ALLEN과 같은 부서에서 근무하는 사원을 조회하시오.
-- 단, ALLEN은 제외한다.
-- 출력
--이름
--부서번호
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'ALLEN')
	AND ENAME != 'ALLEN';

--문제 3
--평균 급여보다 높은 급여를 받는 사원을 조회하시오.
--출력
--이름
--급여
SELECT ENAME, SAL 
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

--문제 4
--가장 최근에 입사한 사원의 정보를 조회하시오.
--출력
--이름
--입사일
--직무
SELECT ENAME, HIREDATE ,JOB
FROM EMP
WHERE HIREDATE  = (SELECT MAX(HIREDATE) FROM EMP);

--문제 5
--급여가 가장 낮은 사원의 정보를 조회하시오.
--출력
--이름
--급여
--부서번호
SELECT ENAME, SAL ,DEPTNO
FROM EMP
WHERE SAL  = (SELECT MIN(SAL) FROM EMP);

--문제 6
--급여가 3000 이상인 사원과 같은 부서에서 근무하는 사원을 조회하시오.
--출력
--이름
--부서번호
--급여
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO FROM EMP
				WHERE SAL >= 3000 );

--문제 7
--MANAGER보다 급여가 많은 사원을 조회하시오.
--출력
--이름
--급여
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE JOB = 'MANAGER');

--문제 8
--SALESMAN보다 급여가 많은 사원을 조회하시오.
--출력
--이름
--급여
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE JOB = 'SALESMAN');

--문제 9
--부서명이 SALES인 부서에서 근무하는 사원을 조회하시오.
--사용 테이블
--EMP
--DEPT
SELECT E.*
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
WHERE DNAME = 'SALES';

--문제 10
--커미션을 받는 사원과 같은 직무를 가진 사원을 조회하시오.
--출력
--이름
--직무
SELECT ENAME, JOB
FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP WHERE COMM IS NOT NULL);


--문제 11
--자신이 속한 부서의 평균 급여보다 높은 급여를 받는 사원을 조회하시오.
--출력
--이름
--부서번호
--급여
SELECT ENAME, DEPTNO, SAL
FROM EMP E
WHERE SAL > (SELECT AVG(SAL) FROM EMP M 
			GROUP BY DEPTNO HAVING M.DEPTNO = E.DEPTNO );

--문제 12
--각 부서에서 가장 높은 급여를 받는 사원을 조회하시오.
--출력
--이름
--부서번호
--급여
SELECT ENAME, DEPTNO, SAL
FROM EMP E
WHERE SAL = (SELECT MAX(SAL) FROM EMP M
			GROUP BY DEPTNO HAVING M.DEPTNO = E.DEPTNO);

--문제 13
--자신과 같은 직무의 평균 급여보다 높은 급여를 받는 사원을 조회하시오.
--출력
--이름
--직무
--급여
SELECT ENAME, JOB, SAL
FROM EMP E
WHERE SAL > (SELECT AVG(SAL) FROM EMP M 
			GROUP BY JOB HAVING M.JOB = E.JOB );

--문제 14
--사원이 존재하는 부서만 조회하시오.
--출력
--부서번호
--부서명
SELECT D.DEPTNO, DNAME
FROM DEPT D
WHERE EXISTS (SELECT * FROM EMP E WHERE E.DEPTNO = D.DEPTNO );

--문제 15
--사원이 한 명도 없는 부서를 조회하시오.
--출력
--부서번호
--부서명
SELECT D.DEPTNO, DNAME
FROM DEPT D
WHERE NOT EXISTS (SELECT * FROM EMP E WHERE E.DEPTNO = D.DEPTNO );

--★ 도전 문제 (심화)
--도전 1 (다중열 서브쿼리)
--부서별 최고 급여를 받는 사원을 조회하시오.
SELECT *
FROM EMP
WHERE (SAL,DEPTNO) IN (SELECT MAX(SAL),DEPTNO FROM EMP GROUP BY DEPTNO );

--도전 2 (다중열 서브쿼리)
--직무별 가장 먼저 입사한 사원을 조회하시오.
SELECT *
FROM EMP
WHERE (HIREDATE,JOB) IN (SELECT MIN(HIREDATE),JOB FROM EMP GROUP BY JOB );


--도전 3 (상관 서브쿼리)
--각 부서에서 가장 늦게 입사한 사원을 조회하시오.
SELECT EMPNO, ENAME, DEPTNO, HIREDATE
FROM EMP E
WHERE E.HIREDATE  IN (SELECT MAX(M.HIREDATE) FROM EMP M
				WHERE M.DEPTNO = E.DEPTNO
				GROUP BY DEPTNO );	


--도전 4 (EXISTS)
--급여등급이 5등급인 사원이 존재하는 부서를 조회하시오.
SELECT DEPTNO
FROM EMP E
WHERE EXISTS (SELECT ENAME FROM SALGRADE S
				WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
				AND GRADE = 5);

--도전 5 (복합 상관 서브쿼리)
--자신의 관리자보다 급여가 많은 사원을 조회하시오.
SELECT ENAME, SAL, MGR
FROM EMP E
WHERE SAL > (SELECT SAL FROM EMP M
			WHERE E.MGR = M.EMPNO);

