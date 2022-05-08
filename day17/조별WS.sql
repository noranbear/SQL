USE companydb;
SELECT * FROM emp;

-- 조별 워크샵

-- 1. 입사일이 23년 지난 직원들의 연봉의 평균을 구하시오.
SELECT AVG(salary) FROM
(SELECT empname, salary FROM emp
WHERE TIMESTAMPDIFF(YEAR, hdate, NOW()) > 23) a;

-- 2. 부서별 입사일이 제일 오래된 직원들 중 연봉이 제일 낮은 사람을 구하시오.
WITH a(deptno, empname, salary, diff)
AS
(SELECT deptno, empname, salary, TIMESTAMPDIFF(day, hdate, NOW()) AS diff FROM emp
GROUP BY deptno
HAVING MAX(diff)
AND deptno IS NOT NULL)
SELECT deptno, empname, salary FROM a
WHERE salary = (SELECT MIN(salary) FROM a);

-- 또는

WITH a(deptno, empname, salary, old)
AS
(SELECT deptno, empname, salary, MAX(hdate) AS old FROM emp
GROUP BY deptno
HAVING deptno IS NOT NULL)
SELECT deptno, empname, salary FROM a
WHERE salary = (SELECT MIN(salary) FROM a);

-- 3. 직급별 가장 높은 연봉의 직원들을 구하시오.
SELECT empname FROM 

(SELECT titleno, MAX(salary) AS msal FROM emp
GROUP BY titleno) a;

SELECT * FROM emp;

-- 4. 이말숙 직원보다 늦게 입사한 직원들의 연봉의 합을 구하시오.

-- 확인용
SELECT empname, salary FROM emp
WHERE hdate > (SELECT hdate FROM emp
WHERE empname = '이말숙');

-- 답
SELECT SUM(salary) FROM emp
WHERE hdate > (SELECT hdate FROM emp
WHERE empname = '이말숙');


