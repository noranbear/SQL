-- companydb
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM title;

INSERT INTO emp VALUES('1011', NULL, NULL, '이말자', NULL, 3000, SYSDATE());
INSERT INTO title VALUES('50', '인턴');


-- 사원 정보를 출력 하시오
-- 사원번호, 사원이름, 부서명, 직급명
SELECT e.empno, e.empname, d.deptname, t.titlename
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
INNER JOIN title t ON e.titleno = t.titleno;

-- INNER JOIN 응용
-- 둘 다 데이터가 있을 때
SELECT d.deptname, ROUND(AVG(e.salary),2)
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno
INNER JOIN title t ON e.titleno = t.titleno
GROUP BY d.deptname;


-- OUTTER JOIN
-- LEFT/RIGHT 기준이 다름
-- 한 쪽 데이터 있고, 다른 한 쪽은 없을 때,
-- title에는 인턴이 있고 emp에는 없음
SELECT * FROM emp e
-- INNER JOIN title t ON e.titleno = t.titleno;
-- title 기준으로 보고 싶기 때문에 right. 인턴나옴, 말자 안나옴
-- RIGHT OUTER JOIN title t ON e.titleno = t.titleno;
-- 인턴 안나옴, 말자 나옴
LEFT OUTER JOIN title t ON e.titleno = t.titleno;

-- LEFT + RIGHT = FULL (두 개의 결과를 합친 모든 결과)
SELECT * FROM emp e
LEFT OUTER JOIN title t ON e.titleno = t.titleno
UNION
SELECT * FROM emp e
RIGHT OUTER JOIN title t ON e.titleno = t.titleno;

-- 사원정보를 출력 하시오
-- 이름, 부서명, 직급명을 출력 한다.
-- 단 이말자도 출력한다.
SELECT * FROM emp e
LEFT OUTER JOIN dept d ON e.deptno = d.deptno
LEFT OUTER JOIN title t ON e.titleno = t.titleno;


-- CROSS JOIN
SELECT * FROM emp e
CROSS JOIN title t;


-- SELF JOIN
SELECT * FROM emp;
-- 사원이름과 매니저이름을 출력하시오.
SELECT e1.empname, e2.empname FROM emp e1
INNER JOIN emp e2 ON e1.manager = e2.empno;

-- 사원이름과 매니저이름을 출력하시오.
-- 단, 모든 직원을 출력하시오. (킹과 말자씨)
SELECT e1.empname, e2.empname FROM emp e1
LEFT OUTER JOIN emp e2 ON e1.manager = e2.empno;

-- 직원정보를 출력한다.
-- 이름, 부서명, 직급명, 매니저명
-- 단, 모든 직원정보를 출력한다.
SELECT e1.empname, d.deptname, t.titlename, e2.empname 
FROM emp e1
LEFT OUTER JOIN emp e2 ON e1.manager = e2.empno
LEFT OUTER JOIN dept d ON e1.deptno = d.deptno
LEFT OUTER JOIN title t ON e1.titleno = t.titleno;


