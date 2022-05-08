USE companydb;

SELECT * FROM emp;

-- 1. 오늘 날짜 기준으로 입사 일부터 며칠이 지났고 몇 달이 지났는지 출력하시오.
SELECT empname, DATEDIFF(NOW(), hdate) AS dayDiff, 
PERIOD_DIFF(DATE_FORMAT(NOW(),'%Y%m'), DATE_FORMAT(hdate, '%Y%m')) AS monthDiff
FROM emp;

SELECT empname, DATEDIFF(NOW(), hdate) AS dayDiff, 
TIMESTAMPDIFF(MONTH, hdate, NOW()) AS monthDiff
FROM emp;

-- 2. 직원들 연봉이 4000이상 이면 high, 2500 이상이면 middle, 2500 이하면 low 출력 (case)
SELECT salary,
CASE
	WHEN salary >= 4000 THEN 'high'
    WHEN salary >= 2500 THEN 'middle'
    ELSE 'low'
END AS salev
FROM emp;

-- 3. 부서별 연봉 평균의 합을 구하시오.
WITH temp(deptno, avgS)
AS
(SELECT deptno, AVG(salary) FROM emp
GROUP BY deptno)
SELECT SUM(avgS) AS SumOfAvgSal FROM temp;

-- 4. 부서별 오늘날짜 기준 입사일 평균을 구하시오.

WITH a(empname, deptno, dd)
AS
(SELECT empname, deptno, TIMESTAMPDIFF(DAY, hdate,NOW()) AS dd
FROM emp
GROUP BY empname)
SELECT deptno, AVG(dd) AS avgdd FROM a
GROUP BY deptno;

-- 되는 것처럼 보이지만 값이 다르다 
-- 부서별로 한 사람 나오게 한 뒤 그 뒤에 부서별로 avg -> 그냥 한 사람 값이 나옴.
WITH a(deptno, dd)
AS
(SELECT deptno, TIMESTAMPDIFF(DAY, hdate,NOW()) AS dd
FROM emp
GROUP BY deptno)
SELECT deptno, AVG(dd) AS avgdd FROM a
GROUP BY deptno;

-- 5. 이말숙 직원과 같은 해에 입사한 직원을 조회 하시오.
SELECT empname FROM emp
WHERE YEAR(hdate) = (SELECT YEAR(hdate) FROM emp
WHERE empname = '이말숙');

-- 6. 부서별 최고 임금을 받는 직원의 평균을 구하고 그 평균보다 많이 받는 직원을 조회 하시오.
SELECT empname, salary FROM emp
WHERE salary >
(SELECT AVG(a.msalary) FROM
(SELECT deptno, MAX(salary) AS msalary FROM emp
GROUP BY deptno) a);

WITH temp(deptno, smax)
AS
(SELECT deptno, MAX(salary) FROM emp
GROUP BY deptno)
SELECT empname, salary FROM emp
HAVING salary > (SELECT AVG(smax) FROM temp);



