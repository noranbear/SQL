DROP TABLE IF EXISTS `usertbl`;

CREATE TABLE `usertbl` (
	`userID`	CHAR(8)	NOT NULL,
	`name`	VARCHAR(10)	NULL,
	`주소`	CHAR(2)	NULL
);

DROP TABLE IF EXISTS `buytbl`;

CREATE TABLE `buytbl` (
	`num`	INT	NOT NULL,
	`userID`	CHAR(8)	NOT NULL,
	`id`	INT	NOT NULL
);

DROP TABLE IF EXISTS `producttbl`;

CREATE TABLE `producttbl` (
	`id`	INT	NOT NULL,
	`name`	VARCHAR(20)	NULL,
	`price`	INT	NULL
);

ALTER TABLE `usertbl` ADD CONSTRAINT `PK_USERTBL` PRIMARY KEY (
	`userID`
);

ALTER TABLE `buytbl` ADD CONSTRAINT `PK_BUYTBL` PRIMARY KEY (
	`num`
);

ALTER TABLE `producttbl` ADD CONSTRAINT `PK_PRODUCTTBL` PRIMARY KEY (
	`id`
);

ALTER TABLE `buytbl` ADD CONSTRAINT `FK_usertbl_TO_buytbl_1` FOREIGN KEY (
	`userID`
)
REFERENCES `usertbl` (
	`userID`
);

ALTER TABLE `buytbl` ADD CONSTRAINT `FK_producttbl_TO_buytbl_1` FOREIGN KEY (
	`id`
)
REFERENCES `producttbl` (
	`id`
);

