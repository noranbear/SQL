-- companydb
-- P270 JSON
SELECT * FROM emp;
SELECT JSON_OBJECT('empno', empno, 'empname', empname)
AS JSONDATA
FROM emp;

-- sqldb
-- JOIN
SELECT * FROM usertbl;
SELECT * FROM buytbl;
