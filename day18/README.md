# Day18

- 여러 개의 테이블을 이용하는 방법을 배움.
- ERD로 테이블 관계 표현.
- 교과서: 이것이 mySQL이다.



## 개요

CH.07 SQL 고급 (P270 ~ P294)

1. [JSON](#JSON) - P270
2. [**JOIN**](#JOIN) - P273
   - [Relation](#Relation)
   - [ERD](#ERD)
     - 20220502
   - [JOIN](#JOIN이란)
     - INNER - P274
     - OUTER - P284
     - CROSS - P288
     - SELF - P290
3. [테이블 분리](#테이블분리)
4. [FILE 설명](#CODES)



## CODES

1. [P270](./P270)
   - JSON 예시
2. [20220502](./20220502)
   - exported ERD
3. [shoppingdb initialization]((./shoppingdb initialization))
   - shoppingdb를 만든다.
   - 테이블의 관계를 정의 하는 법.
     - Alter를 이용한 제약조건 정의
     - Foreign Key 정의

   - 20220502 ERD와 같은 내용
4. [shoppingdb](./shoppingdb)
   - JOIN 개념
5. [2022-05-02 WS](./2022-05-02 WS)
   - WS: 2022-05-02
   - WS: 2022-05-02 2 
6. [2022-05-02 WS2](./2022-05-02 WS2)
   - WS: 2022-05-02 3
7. [2022-05-02 ERD](./2022-05-02 ERD)
   - 2022-05-02 WS ERD SQL

​																																																					[맨 위로](#개요)

---

## JSON

- **JSON (Java Script Object Notation)** 

```sql
SELECT * FROM emp;
SELECT JSON_OBJECT('empno', empno, 'empname', empname)
AS JSONDATA
FROM emp;
```

- Result

  <img src="Day18.assets/JSON RESULT.png" alt="Json result" style="zoom:80%;" />



## JOIN

### Relation

- 데이터베이스의 테이블은 중복과 공간 낭비를 피하고 데이터의 무결성을 위해서 여러 개의 테이블로 분리하여 저장한다.

- 그리고 이 분리된 테이블은 서로 **관계(Relation)**을 맺고 있다.
  - **Foreign Key**
  
    - 테이블 간의 관계를 만들어 준다.
    - ALTER를 사용하여 지정.
  
    ```sql
    -- constraint (제약조건), 관계정립
    ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY (custid) REFERENCES cust(id);
    ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY (itemid) REFERENCES item(id);
    ```
  
    - 한 사람이 여러 개의 상품을 사서 하나의 주문번호를 생성하는 법
    
    <img src="Day18.assets/Relation Ex Image.png" alt="Relation EX image" style="zoom:100%;" />







---

### ERD

- [ERD Cloud](https://www.erdcloud.com/)

<img src="Day18.assets/ERD 기능 설명 Image.png" alt="ERD 기능 설명 Image" style="zoom:80%;" />



- Logical: 비전공자도 알아들을 수 있게 쓰는 곳
- Physical: 실제 계발 용어로 쓰는 곳
- ERD RELATION
  - identifying - main의 FK를 자신의 PK로 씀
  - non-identifying - main의 FK가 자신의 PK가 아님



---

### JOIN이란

- 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만들어 내는 것.

- **JOIN의 4가지 종류**

  - **INNER** - 많이 쓰임

    - 두 테이블에 같은 연관된 데이터가 있을 때 사용

    ```sql
    SELECT * FROM maintbl m
    INNER JOIN (subTbl s) ON (m.foreignKey) = (s.primaryKey)
    
    SELECT * FROM emp e
    INNER JOIN dept d ON e.deptno = d.deptno;
    ```

  - OUTTER

    - 두 테이블의 연관된 정보의 있고 없음이 다를 때 사용

    - LEFT: main tbl기준

      ```sql
      SELECT * FROM maintbl m
      LEFT OUTER JOIN (SAME AS INNER JOIN);
      ```

    - RIGHT: sub tbl기준

      ```sql
      SELECT * FROM maintbl m
      RIGHT OUTER JOIN (SAME AS INNER JOIN);
      

    - FULL: 모든 정보

      ```SQL
      SELECT * FROM maintbl m
      LEFT OUTER JOIN (SAME AS INNER JOIN)
      UNION
      SELECT * FROM maintbl m
      RIGHT OUTER JOIN (SAME AS INNER JOIN);
      ```

- CROSS
  - 한 쪽 테이블의 모든 행들과 다른 쪽 테이블의 모든 행을 조인 (A의 1행 - B의 모든 행)

    ```sql
    SELECT * FROM main m
    CROSS JOIN sub s;
    ```

-  **SELF** - 많이 쓰임

    - A테이블을 A테이블에 조인(자기자신)

      ```sql
      SELECT m1.main, m2.main FROM main m1
      INNER JOIN main m2 ON m1.field1 = m2. field2;
      
      SELECT e1.empname, e2.empname FROM emp e1
      INNER JOIN emp e2 ON e1.manager = e2.empno;
      ```

- JOIN의 종류는 아무거나.





---

### 테이블분리


- 테이블을 굳이 따로 만든 이유 (분리 안 해도 되어 보일 때)

  1. 데이터 바꿀 때의 트러블 최소화

     - emp에 다 넣으면 데이터를 전체적으로 개편해야함.

     - dept라는 테이블을 따로 만들면 dept 테이블에서 바꿀 때

       전체 테이블에서 자동으로 바뀜.

  2. 데이터 자동화를 사용해 들어가는 데이터를 쉽게 통일

     - EX) 통일, 통일부

  3. 단점: 실제 코딩할 때, 더 손이 많이 간다.

     - ERD는 이론적으로 만들고
     - -> 실제적으로는 간소화해서 코딩한다.






[맨 위로](#개요)
