USE shoppingdb;
-- 20220503ERD_SELF 참고

/*
* DDL
*/
DROP DATABASE IF EXISTS shoppingdb;
-- CREATE SCHEMA도 됨
CREATE DATABASE shoppingdb;
USE shoppingdb;

-- 지우는 순서도 중요, 유령 데이터가 남지 않게 조심
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS cust;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS cate;


-- cust table
CREATE TABLE cust(
	id VARCHAR(10),
    name VARCHAR(20) NOT NULL,
    addr VARCHAR(100) NOT NULL,
    regdate DATE NOT NULL
);
ALTER TABLE cust
ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE cust
ALTER COLUMN addr SET DEFAULT 'Seoul';


-- cate table
CREATE TABLE cate(
	id INT,
    name VARCHAR(30) NOT NULL,
    pid INT
);
ALTER TABLE cate
ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE cate
ADD CONSTRAINT UNIQUE (name);

ALTER TABLE cate
ADD CONSTRAINT FOREIGN KEY (pid) REFERENCES cate(id);

-- 테이블 수정
-- ALTER TABLE cate CHANGE COLUMN name name VARCHAR(30) NOT NULL;


-- product table
CREATE TABLE product(
	id INT,
    name VARCHAR(20) NOT NULL,
    price INT NOT NULL,
    regdate DATE NOT NULL,
    cid INT
);
ALTER TABLE product
ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE product MODIFY id INT AUTO_INCREMENT;
ALTER TABLE product AUTO_INCREMENT = 1000;

ALTER TABLE product ADD CONSTRAINT CHECK (price > 0);

ALTER TABLE product
ADD CONSTRAINT FOREIGN KEY (cid) REFERENCES cate(id);


-- cart table
CREATE TABLE cart(
	id INT,
    uid VARCHAR(10),
    pid INT,
    regdate DATE
);
ALTER TABLE cart
ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE cart MODIFY id INT AUTO_INCREMENT;
ALTER TABLE cart AUTO_INCREMENT = 1000;

ALTER TABLE cart 
ADD CONSTRAINT FOREIGN KEY (uid) REFERENCES cust(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE cart
ADD CONSTRAINT FOREIGN KEY (pid) REFERENCES product(id);




