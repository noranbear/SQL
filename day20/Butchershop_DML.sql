USE butchershopdb;

/*
* customer table
*/
DELETE FROM cust;

INSERT INTO cust
VALUES ('norandoly', 'pw12345', 'Sohee Kim', '노원구', curdate());

SELECT * FROM cust;

/*
* cartegory table
*/
DELETE FROM cate;

INSERT INTO cate VALUES (1, NULL, '소');
INSERT INTO cate VALUES (2, NULL, '돼지');
INSERT INTO cate VALUES (3, NULL, '닭');

INSERT INTO cate VALUES (100, 1, '목심');
INSERT INTO cate VALUES (101, 1, '윗등심살');
INSERT INTO cate VALUES (102, 1, '채끝살');

INSERT INTO cate VALUES (200, 2, '갈비');
INSERT INTO cate VALUES (201, 2, '목심살');
INSERT INTO cate VALUES (202, 2, '등심');

INSERT INTO cate VALUES (300, 3, '목살');
INSERT INTO cate VALUES (301, 3, '닭봉');
INSERT INTO cate VALUES (302, 3, '가슴살');

SELECT * FROM cate;

/*
* meat table
*/
DELETE FROM meat;

INSERT INTO meat
VALUES (NULL, 201, 30, 'A', 'KOREA', curdate());
INSERT INTO meat
VALUES (NULL, 200, 35, 'A', 'KOREA', curdate());

INSERT INTO meat
VALUES (NULL, 101, 63, 'A', 'KOREA', curdate());
INSERT INTO meat
VALUES (NULL, 101, 50, 'B+', 'AUSTRALIA', curdate());

INSERT INTO meat
VALUES (NULL, 302, 18, 'A', 'KOREA', curdate());

SELECT * FROM meat;

/*
* cart table
*/
DELETE FROM cart;

INSERT INTO cart
VALUES(NULL, 'norandoly', 1, 200, curdate());
INSERT INTO cart
VALUES(NULL, 'norandoly', 4, 150, curdate());
INSERT INTO cart
VALUES(NULL, 'norandoly', 5, 100, curdate());
INSERT INTO cart (cid, mnum, date)
VALUES('norandoly', 2, curdate());

SELECT * FROM cart;

/*
* payment method table
*/
DELETE FROM payment;

INSERT INTO payment VALUES(NULL, '카드');
INSERT INTO payment VALUES(NULL, '계좌이체'); 
INSERT INTO payment VALUES(NULL, '토스');

SELECT * FROM payment;

/*
* delivery table
*/
DELETE FROM deli;

INSERT INTO deli
VALUES(NULL, '서울시 노원구', 'ㅁ아파트 ㅁ동 ㅁ호', '00000', '김소희',
'010-0000-0000', '부재시 경비실에 맡겨주세요.');

SELECT * FROM deli;

/*
* coupon table
*/
DELETE FROM coupon;

INSERT INTO coupon
VALUES('0000', '소고기 10% 할인권', '2020-05-01', '2020-05-30', '0.1');

SELECT * FROM coupon;

/*
* mycoupon table
*/
DELETE FROM myc;

INSERT INTO myc VALUES(NULL, 'norandoly','0000');

SELECT * FROM myc;

/*
* order table
*/
DELETE FROM ordertbl;

INSERT INTO ordertbl
VALUES(NULL, 'norandoly', 15800, curdate(), 'completed', 1,
curdate(), 1, '준비중', 1);

SELECT * FROM ordertbl;

/*
* detail table
*/
DELETE FROM detail;

INSERT INTO detail VALUES(NULL, 1, 1, 200);
INSERT INTO detail VALUES(NULL, 1, 2, 100);
INSERT INTO detail VALUES(NULL, 1, 4, 150);
INSERT INTO detail VALUES(NULL, 1, 5, 100);

SELECT * FROM detail;

/*
* image table
*/
DELETE FROM image;

INSERT INTO image VALUES(NULL, '먹음직스러운 목심살', 1);

SELECT * FROM image;


