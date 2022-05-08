USE shoppingdb;
/*
* DML
*/
-- cust data
SELECT * FROM cust;

INSERT INTO cust VALUES ('id01', 'lee', 'Busan', '2019-03-02');
-- NOT NULL -> 실행되지 않음
-- INSERT INTO cust (id, name, regdate) 
-- VALUES ('id02', 'kim',NULL, '2020-05-02');
-- default 확인
INSERT INTO cust (id, name, regdate) 
VALUES ('id02', 'kim', '2020-05-02');

-- cate data
SELECT * FROM cate;

INSERT INTO cate VALUES(10, 'pants', NULL);
-- name UNIQUE 확인 -> 실행되지 않음
-- INSERT INTO cate VALUES('20', 'pants', NULL);
-- 유령 데이터 안 들어감 확인 cate 30 존재x
-- INSERT INTO cate VALUES(11, 'short pants', 30);
INSERT INTO cate VALUES(11, 'short pants', 10);

INSERT INTO cate VALUES(20, 'shirts', NULL);
INSERT INTO cate VALUES(21, 'short shirts', 20);

-- 큰 카테고리와 작은 카테고리 연결 (테이블 내부)
-- product로 갈 아이디는 세부 카테고리 id
SELECT * FROM cate c1
INNER JOIN cate c2 ON c1.pid = c2.id;


-- product data
SELECT * FROM product;

-- levis란 이름의 short pants
INSERT INTO product 
VALUES(NULL, 'levis', 10000, curdate(), 11);
-- 음수 들어가지 않는 거 확인 (CHECK)
-- INSERT INTO product 
-- VALUES(NULL, 'bang', -10000, curdate(), 11);
INSERT INTO product 
VALUES(NULL, 'bang', 20000, curdate(), 11);
INSERT INTO product 
VALUES(NULL, 'levis', 10000, curdate(), 21);
INSERT INTO product 
VALUES(NULL, 'bang', 20000, curdate(), 21);

-- 제품의 정보를 출력한다.
-- 카테고리명도 출력한다.
SELECT * FROM product p
INNER JOIN cate ct ON p.cid = ct.id;


-- cart data
SELECT * FROM cart;

INSERT INTO cart VALUES (NULL, 'id01', 1000, curdate());
INSERT INTO cart VALUES (NULL, 'id01', 1001, curdate());
INSERT INTO cart VALUES (NULL, 'id01', 1003, curdate());

-- cart 정보를 출력하시오
-- 사용자이름, 상품이름, 상품가격, 카테고리이름
SELECT c.name, p.name, p.price, ct.name FROM cart ca
INNER JOIN cust c ON ca.uid = c.id
INNER JOIN product p ON ca.pid = p.id
INNER JOIN cate ct ON p.cid = ct.id;

-- PRIMARY KEY의 변경
-- FOREIGN KEY로 썼어서 다른 테이블에 이 KEY와 연관된 정보들 때문에
-- 그냥 변경은 불가. -> 원래는 테이블을 순서대로 삭제해야 함
-- DELETE FROM cust WHERE id = 'id01';
-- UPDATE cust SET id='id001' WHERE id='id01';

-- ON UPDATE CASCADE/ ON DELETE CASCADE 실험
-- DELETE FROM cart;
-- DELETE FROM cust WHERE id = 'id01';
-- UPDATE cust SET id='id001' WHERE id='id01';


/* VIEW */
SELECT ca.id, c.id AS uid, c.name AS uname, p.id AS pid, 
p.name AS pname, p.price, ct.name AS ctname, ca.regdate 
FROM cart ca
INNER JOIN cust c ON ca.uid = c.id
INNER JOIN product p ON ca.pid = p.id
INNER JOIN cate ct ON p.cid = ct.id;

-- Make View Table

CREATE VIEW v_cart
AS
SELECT ca.id, c.id AS uid, c.name AS uname, p.id AS pid, 
p.name AS pname, p.price, ct.name AS ctname, ca.regdate 
FROM cart ca
INNER JOIN cust c ON ca.uid = c.id
INNER JOIN product p ON ca.pid = p.id
INNER JOIN cate ct ON p.cid = ct.id;

-- data가 바뀌면 view도 바뀜.
UPDATE cart SET regdate= '2020-05-03' WHERE id = 1000;
SELECT * FROM v_cart;
-- view tbl을 업데이트해도 cart tbl이 바뀐다.
UPDATE v_cart SET regdate= '2019-05-03' WHERE id = 1000;


SELECT * FROM cart ca
INNER JOIN cust c ON ca.uid = c.id
INNER JOIN product p ON ca.pid = p.id
INNER JOIN cate ct ON p.cid = ct.id;
