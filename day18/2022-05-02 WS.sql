-- companydb
SELECT * FROM emp;

-- 1. 직원정보를 출력한다. 직원의 연봉정보와 연봉의 세금정보를 같이 출력한다.
-- 세금은 10%
SELECT empname, salary, (salary * 0.10) AS tax FROM emp;

-- 2. 직원정보 중 2001 이전에 입사하였고 월급이 4000만원 미만인 직원을 조회
SELECT empname FROM emp
WHERE YEAR(hdate) < '2001'
AND
salary < 4000;

-- 3. manager가 있는 직원 중 이름에 '자'가 들어가 있는 직원정보 조회
SELECT * FROM emp
WHERE manager IS NOT NULL
AND
empname LIKE '%자%';

-- 4. 월급이 2000미만은 '하' 4000미만은 '중' 4000이상은 '고' 를 출력
SELECT empname, salary,
CASE
	WHEN salary < 2000 THEN '하'
    WHEN salary < 4000 THEN '중'
    WHEN salary >= 4000 THEN '고'
    ELSE 'None'
END AS slevel
FROM emp;


-- 2)

-- 5. 부서 별 월급의 평균을 구하시오
-- 단, 평균이 3000 이상인 부서만 출력
SELECT a.deptno FROM
(SELECT deptno, salary FROM emp
GROUP BY deptno)a
HAVING AVG(salary) >= 3000;

-- 6. 부서 별 대리와 사원 연봉의 평균을 구하시오
-- 단, 평균이 2500 이상인 부서만 출력
SELECT t.titlename, ROUND(AVG(e.salary),2) AS avgSalary FROM emp e
INNER JOIN title t ON e.titleno = t.titleno
GROUP BY t.titlename
HAVING t.titlename IN('대리','사원')
AND avgSalary >= 2500;

-- 7. 2000년부터 2002년에 입사한 직원들의 월급의 평균을 구하시오
SELECT YEAR(hdate) AS year, ROUND(AVG(salary), 2) AS avgSalary FROM emp
GROUP BY YEAR(hdate)
HAVING year BETWEEN '2000' AND '2002';

-- 8. 부서 별 월급의 합의 ranking을 1위부터 조회 하시오
SELECT deptno, salary AS tSalary FROM emp
GROUP BY deptno
ORDER BY salary DESC;

-- 9. 서울에서 근무하는 직원들을 조회 하시오
SELECT e.empname FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
WHERE d.deptloc = '서울';

-- 10. 이영자가 속한 부서의 직원들을 조회 하시오.
SELECT empname FROM emp
WHERE deptno = (SELECT deptno FROM emp
WHERE empname = '이영자');

-- 11. 김강국의 타이틀과 같은 직원들을 조회 하시오
SELECT empname FROM emp
WHERE titleno = (SELECT titleno FROM emp
WHERE empname = '김강국');



