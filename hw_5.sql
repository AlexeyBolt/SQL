Use hw_5;
DROP TABLE IF EXISTS cars;
CREATE TABLE IF NOT EXISTS cars 
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(40) NOT NULL,
	cost INT NOT NULL
);

INSERT INTO cars(name, cost) VALUES
("Audi", 52642),
("Mercedes", 57127),
("Skoda", 9000),
("Volvo", 29000),
("Bentley", 350000),
("Citroen", 21000),
("Hummer", 41400),
("Volkswagen", 21600);

SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25000 долларов.
create or replace view  cars_25 as
select id, name, cost
from cars
where cost<25000; 
select * from cars_25;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
alter view cars_25
as
select *
from cars
where cost<30000; 
select * from cars_25;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE or replace VIEW SkodaAudiCars AS
SELECT * 
FROM cars 
WHERE name IN ('Skoda', 'Audi');
SELECT * FROM SkodaAudiCars;

-- 4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

DROP TABLE IF EXISTS analys;
CREATE TABLE analys (
  an_id INT PRIMARY KEY,
  an_name VARCHAR(50),
  an_cost INT,
  an_price INT,
  an_group VARCHAR(50)
);

INSERT INTO analys(an_id, an_name, an_cost, an_price, an_group) VALUES
(1, 'анализ 1', 100, 200, 'группа 1'),
(2, 'анализ 2', 150, 250, 'группа 2'),
(3, 'анализ 3', 120, 220, 'группа 3'),
(4, 'анализ 4', 80, 180, 'группа 4'),
(5, 'анализ 11', 90, 190, 'группа 1'),
(6, 'анализ 22', 110, 210, 'группа 2');
DROP TABLE IF EXISTS groups_an;
CREATE TABLE groups_an (
  gr_id INT PRIMARY KEY,
  gr_name VARCHAR(50),
  gr_temp VARCHAR(50)
);

INSERT INTO groups_an(gr_id, gr_name, gr_temp) VALUES
(1, 'группа 1', 'А'),
(2, 'группа 2', 'Б'),
(3, 'группа 3', 'В'),
(4, 'группа 4', 'Г');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  ord_id INT PRIMARY KEY,
  ord_datetime DATE,
  ord_an INT
);

INSERT INTO orders(ord_id, ord_datetime, ord_an) VALUES
(1, '2020-01-05', 1),
(2, '2020-02-12', 2),
(3, '2020-02-07', 3),
(4, '2020-02-06', 4),
(5, '2020-02-08', 5),
(6, '2020-02-05', 6),
(7, '2020-02-08', 1),
(8, '2020-02-10', 2),
(9, '2020-02-11', 3),
(10, '2020-02-13', 4);

select * from analys;
select * from groups_an;
select * from orders;
SELECT analys.an_name, analys.an_price
FROM analys
INNER JOIN orders 
ON analys.an_id = orders.ord_an
WHERE orders.ord_datetime >= '2020-02-05' 
AND orders.ord_datetime <= '2020-02-12';

-- 5. Добавьте новый столбец под названием "Время до следующей станции". 

DROP TABLE IF EXISTS time_stantion;
CREATE TABLE time_stantion (
  train_id integer NOT NULL,
  station varchar(20) NOT NULL,
  station_time time NOT NULL
);

INSERT time_stantion 
    (train_id, station, station_time)
  VALUES 
    (110, 'San Francisco', '10:00:00'),
    (110, 'Redwood City', '10:54:00'),
    (110, 'Palo Alto', '11:02:00'),
    (110, 'San Jose', '12:35:00'),
    (120, 'San Francisco', '11:00:00'),
    (120, 'Palo Alto', '12:49:00'),
    (120, 'San Jose', '13:30:00');
    
SELECT * FROM time_stantion;
SELECT *,
	SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY station_time), station_time) 
	AS time_to_next_station 
FROM time_stantion;