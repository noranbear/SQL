/**
* JOIN / VIEW
**/
USE butchershopdb;

-- 쿠폰 부분은 수정 필요

/*
* 상품 뷰
* 카테고리명, 고기이름, 가격(100g일때), 할인가격, 배송예상일, 가격, 생산일자, 고기번호, 원산지, 고기등급
*/
DROP VIEW IF EXISTS v_meatInfo;

CREATE VIEW v_meatInfo
AS
SELECT ct2.name AS category, ct1.name AS name, (m.price * 100) AS price100g, 
((m.price * 100) - (m.price * 100 * cp.rate)) AS disPrice, (curdate() + 4) AS estDdate, 
m.price AS price1g, m.death AS made, m.no AS meatNo, m.country, m.grade
FROM meat m
LEFT OUTER JOIN cate ct1 ON m.ctnum = ct1.no
LEFT OUTER JOIN cate ct2 ON ct1.ctnum = ct2.no
LEFT OUTER JOIN cart ca ON m.no = ca.mnum
LEFT OUTER JOIN cust c ON ca.cid = c.id
LEFT OUTER JOIN myc mc ON c.id = mc.cid
LEFT OUTER JOIN coupon cp ON mc.cpnum = cp.no;

SELECT * FROM v_meatInfo;

/*
* 장바구니 뷰
* 상품명(종류포함), 주문량, 국가, 등급, 가격, 할인량, 할인가격
*/
DROP VIEW IF EXISTS v_cart;

CREATE VIEW v_cart
AS
SELECT ct2.name AS category, ct1.name, ca.amt AS amount, m.country, m.grade, 
(ca.amt * m.price) AS price, cp.rate AS discount,
((ca.amt * m.price)-(ca.amt * m.price * cp.rate)) AS disPrice
FROM cart ca
LEFT OUTER JOIN meat m ON ca.mnum = m.no
LEFT OUTER JOIN cate ct1 ON m.ctnum = ct1.no
LEFT OUTER JOIN cate ct2 ON ct1.ctnum = ct2.no
LEFT OUTER JOIN cust c ON ca.cid = c.id
LEFT OUTER JOIN myc mc ON c.id = mc.cid
LEFT OUTER JOIN coupon cp ON mc.cpnum = cp.no;

SELECT * FROM v_cart;

/* 
* 주문정보 뷰
* 고객이름, 받는사람, 배송지, 우편번호, 전화번호, 주문날짜, 배송상태, 결제날짜, 결제상태,
* 총금액
*/
DROP VIEW IF EXISTS v_order;

CREATE VIEW v_order
AS
SELECT c.name AS custName, d.rece AS receiver, d.add1 AS addr, 
d.add2 AS addDetail, d.zip AS zipcode, d.phone, o.odate AS orderDate,
o.dstat AS deliStat, o.pdate AS payDate, o.ostat AS orderStat, 
(o.tprice -(o.tprice * cp.rate)) AS total
FROM ordertbl o
INNER JOIN cust c ON o.cid = c.id
INNER JOIN deli d ON o.dnum = d.no
INNER JOIN myc mc ON o.cpid = mc.id
INNER JOIN coupon cp ON mc.cpnum = cp.no;

SELECT * FROM v_order;

/*
* 주문상세정보 뷰
* 주문번호, 상품명, 배송상태, 주문량, 가격, 등급, 생산지, 고기별 총금액
*/
DROP VIEW IF EXISTS v_odetail;

CREATE VIEW v_odetail
AS
SELECT o.no, ct2.name AS category, ct1.name AS meat, o.dstat AS dstatus, 
dt.amt AS amount, m.price, (dt.amt * m.price) AS total, m.grade, m.country 
FROM detail dt
INNER JOIN ordertbl o ON dt.onum = o.no
INNER JOIN meat m ON dt.mnum = m.no
INNER JOIN deli d ON o.dnum = d.no
INNER JOIN cate ct1 ON m.ctnum = ct1.no
INNER JOIN cate ct2 ON ct1.ctnum = ct2.no
INNER JOIN myc mc ON o.cpid = mc.id
INNER JOIN coupon cp ON mc.cpnum = cp.no
WHERE o.no = 1;

SELECT * FROM v_odetail;








