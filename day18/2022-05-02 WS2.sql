SELECT * FROM emp;
SELECT * FROM dept;

-- 1. 2000년 이후 입사한 사원들의 정보를 출력
-- 사번, 이름, 타이틀, 부서, 지역
SELECT e.empno, e.empname, t.titlename, d.deptname, d.deptloc FROM emp e
INNER JOIN title t ON e.titleno = t.titleno
INNER JOIN dept d ON e.deptno = d.deptno
WHERE YEAR(hdate) > '2000';

-- 2. 부서이름 별 월급의 평균을 구하시오
-- 단, 평균이 3000 이상인 부서만 출력
SELECT d.deptname, ROUND(AVG(e.salary),2) AS avgSalary FROM emp e
INNER JOIN title t ON e.titleno = t.titleno
INNER JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptname
HAVING avgSalary >= 3000;

SELECT d.deptname FROM emp e
INNER JOIN title t ON e.titleno = t.titleno
INNER JOIN dept d ON e.deptno = d.deptno
GROUP BY d.deptname
HAVING AVG(e.salary) >= 3000;

-- 3. 대구 지역의 직원들의 평균연봉을 구하시오
SELECT d.deptloc, ROUND(AVG(e.salary),2) AS avgSalary FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
WHERE d.deptloc = '대구';

-- 4. 홍영자 직원과 같은 부서직원들의 근무월수를 구하시오 
SELECT e.empname, period_diff(DATE_FORMAT(NOW(), '%Y%m'), DATE_FORMAT(e.hdate, '%Y%m')) AS month
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 
(SELECT e.deptno FROM emp e
WHERE e.empname = '홍영자');

SELECT e.empname, timestampdiff(MONTH, e.hdate, NOW()) AS month
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 
(SELECT e.deptno FROM emp e
WHERE e.empname = '홍영자');

-- 5. 입사년수가 가장 많은 직원 순으로 정렬하여 순위를 정한다.
-- 이름, 부서명, 직위, 년수
SELECT e.empname, d.deptname, t.titlename, timestampdiff(YEAR, e.hdate, NOW()) AS year FROM emp e
LEFT OUTER JOIN dept d ON e.deptno = d.deptno
LEFT OUTER JOIN title t ON e.titleno = t.titleno
ORDER BY year DESC;


