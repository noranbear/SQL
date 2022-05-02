-- 1 . 연봉이 1000 ~ 3000 사이의 사람들의 정보를 조회하시오
SELECT empname from emp
WHERE salary BETWEEN 1000 AND 3000;

-- 2. 이영업과 매니저가 같은 직원을 조회하여 그 직원들의 연봉 평균을 구하시오.
SELECT ROUND(AVG(salary), 2) AS avgSalary FROM emp
WHERE manager = (SELECT manager FROM emp
WHERE empname = '이영업');
​
-- 3. 문제 성이 김씨인 직원들의 평균 연봉을 구하고 이들 평균 연봉 보다 낮은 연봉의 직원의 근속일수를 구하시오. (근속일수는 현재-입사일)

​

-- 4. 이름이 '홍' 과 '이' 로 시작하는 사람들 평균 연봉들을 구하시오