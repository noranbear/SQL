-- shoppingdb
SELECT * FROM cust;
SELECT * FROM item;
SELECT * FROM cart;

-- CART 테이블에 값넣기

-- ID99인 사람이 존재하지 않을 때 -> 에러
-- INSERT INTO cart 
-- VALUES (NULL,'id99',1000,10,CURRENT_DATE());

INSERT INTO cart 
VALUES (NULL,'id02',1001,5,CURRENT_DATE());

INSERT INTO cart 
VALUES (NULL,'id02',1002,7,CURRENT_DATE());

INSERT INTO cart 
VALUES (NULL,'id03',1000,3,CURRENT_DATE());


-- JOIN - 여러개의 테이블을 같이 보여주는 것.
SELECT * FROM cart
INNER JOIN cust ON cart.custid = cust.id;

-- 위 구문 alias (AS) -- 주인공이 맨 위.
SELECT * FROM cart c
INNER JOIN cust cu ON c.custid = cu.id;

-- 세 개의 테이블 JOIN해서 출력
SELECT * FROM cart c
INNER JOIN cust cu ON c.custid = cu.id
INNER JOIN item i ON c.itemid = i.id;

-- 필요한 것만 출력 (장바구니에 출력되는 모양)
SELECT c.id, cu.name, i.price, (c.num * i.price) FROM cart c
INNER JOIN cust cu ON c.custid = cu.id
INNER JOIN item i ON c.itemid = i.id;

-- + 조건 (GROUP BY도 가능)
SELECT c.id, cu.name, i.price, (c.num * i.price) FROM cart c
INNER JOIN cust cu ON c.custid = cu.id
INNER JOIN item i ON c.itemid = i.id
WHERE i.price > 15000;

SELECT c.id, cu.name, i.price, SUM(c.num * i.price) FROM cart c
INNER JOIN cust cu ON c.custid = cu.id
INNER JOIN item i ON c.itemid = i.id
GROUP BY cu.name;

-- 장바구니에 고객이름 별 총 금액의 평균을 구하시오. (+ 10만보다 큰 사람)
SELECT cu.name, ROUND(AVG(c.num * i.price), 2) AS totalAvg 
FROM cart c
INNER JOIN cust cu ON c.custid = cu.id
INNER JOIN item i ON c.itemid = i.id
GROUP BY cu.name
HAVING totalAvg >= 100000;

