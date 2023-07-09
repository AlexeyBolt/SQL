


DROP TABLE users;
CREATE TABLE users (
username VARCHAR(50) PRIMARY KEY,
password VARCHAR(50) NOT NULL,
status VARCHAR(10) NOT NULL);

CREATE TABLE users_profile (
username VARCHAR(50) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE);

INSERT INTO users values
('admin' , '7856', 'Active'),
('staff' , '90802', 'Active'),
('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );


SELECT * FROM users_profile;

/*
Cсылка на материалы для работы:https://drive.google.com/file/d/1J5UCDn8hksQmNFogOIqfgZ8eRKy2PA6q/view?usp=sharing
1.	Используя СТЕ, выведите всех пользователей из таблицы users_profile
2.	Используя СТЕ, подсчитайте количество активных пользователей . 
Задайте псевдоним результирующему окну. Пример:
3. 	С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10:(пример для чисел от 1 до 3)
*/


-- 1
WITH cte1 AS 
(
	SELECT username FROM users_profile
)
SELECT * FROM cte1
WHERE username = 'admin';

-- 2
WITH cte2 AS
(
	SELECT status, COUNT(*) as kol
    FROM users GROUP BY status
)
SELECT kol FROM cte2
WHERE status = 'active';





WITH RECURSIVE sequence (n) AS
(
  SELECT 0
  UNION ALL
  SELECT n + 1 
  FROM sequence 
  WHERE n + 1 <= 10
)
SELECT n
FROM sequence;

WITH RECURSIVE cte AS
(
	SELECT 1 AS a
	UNION ALL
	SELECT a + 1 FROM cte
	WHERE a < 10
)
SELECT * FROM cte;

-- 3.	С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10
WITH RECURSIVE cte2 AS
(
	SELECT 1 AS n, 1 AS 'n^2'
	UNION ALL
	SELECT n + 1 as n, POW(n + 1, 2) as 'n^2' FROM cte2
	WHERE n < 10
)
SELECT * FROM cte2;




/*
Собрать дэшборд, в котором содержится информация о максимальной задолженности
 в каждом банке, а также средний размер процентной ставки в каждом банке в зависимости
 от сегмента и количество договоров всего всем банкам
*/

SELECT *,
MAX(osz) OVER(PARTITION BY tb) as 'максимальной задолженности',
AVG(procent_rate) OVER(PARTITION BY tb, segment) as 'средний размер процентной ставки',
COUNT(id_dog) OVER() as 'количество договоров'
FROM t1;




SELECT * 
, ROW_NUMBER() OVER(ORDER BY count_revisions desc)
, Rank() OVER(ORDER BY count_revisions desc)
, DENSE_RANK() OVER(ORDER BY count_revisions desc)
, NTILE(3) OVER(ORDER BY count_revisions desc)
FROM Table_Rev;

DROP TABLE bank_table;
CREATE TABLE `bank_table` (
  `idbank_table` INT NOT NULL,
  `tb` VARCHAR(45) NULL,
  `dep` VARCHAR(45) NULL,
  `count_revisions` INT NULL,
  PRIMARY KEY (`idbank_table`));


INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('1', 'A', 'Corp', 100);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('2', 'A', 'Rozn', 47);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('3', 'A', 'IT', 86);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('4', 'B', 'Corp', 70);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('5', 'B', 'Rozn', 65);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('6', 'B', 'IT', 58);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('7', 'C', 'Corp', 42);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('8', 'C', 'Rozn', 40);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('9', 'C', 'IT', 63);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('10', 'D', 'Corp', 95);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('11', 'D', 'Rozn', 120);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('12', 'D', 'IT', 85);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('13', 'E', 'Corp', 70);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('14', 'E', 'Rozn', 72);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('15', 'E', 'IT', 80);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('16', 'F', 'Corp', 66);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('17', 'F', 'Rozn', 111);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('18', 'F', 'IT', 33);


SELECT * FROM bank_table;
-- Найти второй отдел во всех банках по количеству ревизий
WITH cte3 AS
(
	SELECT *,
    DENSE_RANK() OVER(PARTITION BY tb ORDER BY count_revisions DESC) as ds
    FROM bank_table
)
SELECT * FROM cte3
WHERE ds = 2;






CREATE TABLE tasks (
  `id_tasks` INT NOT NULL,
  `event` VARCHAR(45) NOT NULL,
  `date_event` DATETIME NOT NULL);
  
  
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Open', '2020-02-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'To_1_Line', '2020-02-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'To_2_Line', '2020-02-03');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Successful', '2020-02-04');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Close', '2020-02-05');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'Open', '2020-03-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'To_1_Line', '2020-03-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'Denied', '2020-03-03');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'Open', '2020-04-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'To_1_Line', '2020-04-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'To_2_Line', '2020-04-03');


SELECT * FROM tasks;

SELECT *,
LEAD(event, 1, 'end') OVER (PARTITION BY id_tasks ORDER BY date_event) as 'next_event',
LEAD(date_event, 1, '2099-01-01') OVER (PARTITION BY id_tasks ORDER BY date_event) as 'next_date'
FROM tasks;

