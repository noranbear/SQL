DROP TABLE IF EXISTS `title`;

CREATE TABLE `title` (
	`titleno`	CHAR(2)	NOT NULL,
	`titilename`	VARCHAR(20)	NULL
);

DROP TABLE IF EXISTS `emp`;

CREATE TABLE `emp` (
	`empno`	CHAR(4)	NOT NULL,
	`empname`	VARCHAR(10)	NULL,
	`manager`	CHAR(4)	NULL,
	`salary`	INT	NULL,
	`hdate`	DATE	NULL,
	`titleno`	CHAR(2)	NOT NULL,
	`deptno`	CHAR(2)	NOT NULL
);

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
	`deptno`	CHAR(2)	NOT NULL,
	`deptname`	VARCHAR(20)	NULL,
	`deptloc`	VARCHAR(20)	NULL
);

ALTER TABLE `title` ADD CONSTRAINT `PK_TITLE` PRIMARY KEY (
	`titleno`
);

ALTER TABLE `emp` ADD CONSTRAINT `PK_EMP` PRIMARY KEY (
	`empno`
);

ALTER TABLE `dept` ADD CONSTRAINT `PK_DEPT` PRIMARY KEY (
	`deptno`
);

ALTER TABLE `emp` ADD CONSTRAINT `FK_title_TO_emp_1` FOREIGN KEY (
	`titleno`
)
REFERENCES `title` (
	`titleno`
);

ALTER TABLE `emp` ADD CONSTRAINT `FK_dept_TO_emp_1` FOREIGN KEY (
	`deptno`
)
REFERENCES `dept` (
	`deptno`
);

