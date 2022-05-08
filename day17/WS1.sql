USE companydb;

-- WS1
-- 1. 부서별, 직급별 연봉 평균을 구하시오.

SELECT deptno, ROUND(AVG(salary),2) AS ysalary FROM emp
GROUP BY deptno;

SELECT titleno, ROUND(AVG(salary),2) AS ysalary FROM emp
GROUP BY titleno;

-- 2. 입사 년도 별 월급의 평균을 구하시오.

SELECT YEAR(hdate) AS hyear, AVG(salary) AS avgsalary FROM emp
GROUP BY YEAR(hdate);

-- 3. 부서 별 입사 월을 기준으로 연봉의 합을 구하시오

SELECT MONTH(hdate) AS hmonth, SUM(salary) AS ssum FROM emp
GROUP BY MONTH(hdate);

-- 4. 이영업이 속한 부서의 연봉의 평균을 구하시오

SELECT deptno, ROUND(AVG(salary)) AS avgsalary FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE empname = '이영업');

-- 5. 홍영자 직급과 같은 직원들의 연봉 평균보다 많이 받는 직원을 구하시오

SELECT empname, salary FROM emp
GROUP BY empname
HAVING AVG(salary) > (SELECT AVG(salary) FROM emp
WHERE titleno = (SELECT titleno FROM emp
WHERE empname = '홍영자'));

-- 6. 회사내 매니저는 총 몇 명인지 구하시오

SELECT COUNT(DISTINCT(manager)) FROM emp;

-- 7 2000-01-01부터 2002-12-31일까지 입사한 직원들의 연봉 평균을 구하시오

SELECT empname, ROUND(AVG(salary)) AS avgsalary FROM emp
WHERE hdate BETWEEN '2000-01-01' AND '2002-12-31';


