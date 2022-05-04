/**
* According to ButcherShop_ERD
**/
DROP DATABASE IF EXISTS butchershopdb;
CREATE DATABASE butchershopdb;
USE butchershopdb;

-- DROP TABLE

DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS detail;
DROP TABLE IF EXISTS meat;
DROP TABLE IF EXISTS cate;
DROP TABLE IF EXISTS ordertbl;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS deli;
DROP TABLE IF EXISTS cust;
DROP TABLE IF EXISTS myc;
DROP TABLE IF EXISTS coupon;

/*
DDL CREATION
WARNING
1. DROP TABLE order
2. TABLE CREATION order

ORDER
1. NULL
2. PRIMARY KEY---
	ALTER TABLE cust
	ADD CONSTRAINT PRIMARY KEY (id);
3. FORIEGN KEY---
	ALTER TABLE cart 
	ADD CONSTRAINT FOREIGN KEY (uid) REFERENCES cust(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
4. AUTO_INCREMENT---
	ALTER TABLE product MODIFY id INT AUTO_INCREMENT;
	ALTER TABLE product AUTO_INCREMENT = 1000;
5. UNIQUE---
	ALTER TABLE cate
	ADD CONSTRAINT UNIQUE (name);
6. CHECK---
	ALTER TABLE product ADD CONSTRAINT CHECK (price > 0);
7. DEFAULT---  (NOT NULL 있어야 함)
	ALTER TABLE cust
	ALTER COLUMN addr SET DEFAULT 'Seoul';
*/

-- TABLE CREATION

/*
* customer table
*/
CREATE TABLE cust(
	id VARCHAR(30),
    pw VARCHAR(30) NOT NULL,
    name VARCHAR(30) NOT NULL,
    addr VARCHAR(100) NOT NULL,
    regdate DATE NOT NULL
);

ALTER TABLE cust ADD CONSTRAINT PRIMARY KEY (id);

ALTER TABLE cust ADD CONSTRAINT CHECK (LENGTH(pw) > 6);

/*
* category table
*/
CREATE TABLE cate(
	no INT,
    ctnum INT,
    name VARCHAR(20) NOT NULL
);

ALTER TABLE cate ADD CONSTRAINT PRIMARY KEY (no);

ALTER TABLE cate
ADD CONSTRAINT FOREIGN KEY (ctnum) REFERENCES cate(no)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 돼지 목심, 소 목심의 경우, 불가.
-- ALTER TABLE cate ADD CONSTRAINT UNIQUE (name);

/*
* meat table
*/
CREATE TABLE meat(
	no INT,
    ctnum INT NOT NULL,
    price DOUBLE NOT NULL,
    grade VARCHAR(3) NOT NULL,
    country VARCHAR(20) NOT NULL,
    death DATE NOT NULL
);

ALTER TABLE meat ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE meat MODIFY no INT AUTO_INCREMENT;

ALTER TABLE meat
ADD CONSTRAINT FOREIGN KEY (ctnum) REFERENCES cate(no)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE meat ADD CONSTRAINT CHECK (price >= 0);
-- INSERT 할 때, 귀찮
-- ALTER TABLE meat ALTER COLUMN grade SET DEFAULT 'A';

/*
* cart table
*/
CREATE TABLE cart(
	no INT,
    cid VARCHAR(30) NOT NULL,
    mnum INT NOT NULL,
    amt INT NOT NULL,
    date DATE NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE cart MODIFY no INT AUTO_INCREMENT;

ALTER TABLE cart
ADD CONSTRAINT FOREIGN KEY (cid) REFERENCES cust(id);
ALTER TABLE cart
ADD CONSTRAINT FOREIGN KEY (mnum) REFERENCES meat(no)
ON DELETE CASCADE;

ALTER TABLE cart ADD CONSTRAINT CHECK (amt > 0);
ALTER TABLE cart ALTER COLUMN amt SET DEFAULT 100;

/*
* payment method table
*/
CREATE TABLE payment(
	no INT,
    method VARCHAR(20) NOT NULL
    -- method가 카드, 토스 등으로 나눠지는데, date가 다 달라지면,
    -- 카드 테이블 여러개, 토스 테이블 여러개가 됨.
    -- date DATE NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE payment MODIFY no INT AUTO_INCREMENT;

/*
* delivery table
*/
CREATE TABLE deli(
	no INT,
    add1 VARCHAR(30) NOT NULL,
    add2 VARCHAR(30),
    zip CHAR(5) NOT NULL,
    rece VARCHAR(30) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    memo VARCHAR(100)
);

ALTER TABLE deli ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE deli MODIFY no INT AUTO_INCREMENT;

/*
* coupon table
*/
CREATE TABLE coupon(
	no VARCHAR(30),
    name VARCHAR(30),
    issue DATE NOT NULL,
    exp DATE NOT NULL,
    rate DOUBLE NOT NULL
);

ALTER TABLE coupon ADD CONSTRAINT PRIMARY KEY (no);

ALTER TABLE coupon ADD CONSTRAINT CHECK (rate > 0);
ALTER TABLE coupon ALTER COLUMN rate SET DEFAULT 0.1;

/*
* mycoupon table
*/
CREATE TABLE myc(
	id INT,
    cid VARCHAR(30) NOT NULL,
    cpnum VARCHAR(30) NOT NULL
);

ALTER TABLE myc ADD CONSTRAINT PRIMARY KEY (id);
ALTER TABLE myc MODIFY id INT AUTO_INCREMENT;

ALTER TABLE myc
ADD CONSTRAINT FOREIGN KEY (cid) REFERENCES cust(id);
ALTER TABLE myc
ADD CONSTRAINT FOREIGN KEY (cpnum) REFERENCES coupon(no);

/*
* order table
*/
CREATE TABLE ordertbl (
	no INT,
    cid VARCHAR(30) NOT NULL,
    tprice DOUBLE NOT NULL,
    odate DATE NOT NULL,
    ostat VARCHAR(20) NOT NULL,
    pnum INT,
    -- payment method에 있던 결제일을 여기로
    pdate DATE,
    dnum INT,
    dstat VARCHAR(20) NOT NULL,
    cpid INT
    
);

ALTER TABLE ordertbl ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE ordertbl MODIFY no INT AUTO_INCREMENT;

ALTER TABLE ordertbl
ADD CONSTRAINT FOREIGN KEY (cid) REFERENCES cust(id);
ALTER TABLE ordertbl
ADD CONSTRAINT FOREIGN KEY (pnum) REFERENCES payment(no);
ALTER TABLE ordertbl
ADD CONSTRAINT FOREIGN KEY (dnum) REFERENCES deli(no);
ALTER TABLE ordertbl
ADD CONSTRAINT FOREIGN KEY (cpid) REFERENCES myc(id);

ALTER TABLE ordertbl ADD CONSTRAINT CHECK (tprice >= 0);
ALTER TABLE ordertbl ALTER COLUMN dstat SET DEFAULT 'Preparing';
ALTER TABLE ordertbl ALTER COLUMN ostat SET DEFAULT 'Uncompleted';

/*
*  order detail table
*/
CREATE TABLE detail(
	no INT,
    onum INT NOT NULL,
    mnum INT NOT NULL,
    amt INT NOT NULL
);

ALTER TABLE detail ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE detail MODIFY no INT AUTO_INCREMENT;

ALTER TABLE detail
ADD CONSTRAINT FOREIGN KEY (onum) REFERENCES ordertbl(no);
ALTER TABLE detail
ADD CONSTRAINT FOREIGN KEY (mnum) REFERENCES meat(no);

ALTER TABLE detail ADD CONSTRAINT CHECK (amt > 0);
ALTER TABLE detail ALTER COLUMN amt SET DEFAULT 100;

/*
* image table
*/
CREATE TABLE image(
	no INT,
    name VARCHAR(20),
    mnum INT NOT NULL
);

ALTER TABLE image ADD CONSTRAINT PRIMARY KEY (no);
ALTER TABLE image MODIFY no INT AUTO_INCREMENT;

ALTER TABLE image
ADD CONSTRAINT FOREIGN KEY (mnum) REFERENCES meat(no)
ON DELETE CASCADE;











