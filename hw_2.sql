use hw_2;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
order_date DATE NOT NULL,
bucket VARCHAR(50) NOT NULL
);

INSERT INTO sales (order_date, bucket)
VALUES 
("2021-01-01", "101 to 300"),
("2021-01-02", "101 to 300"),
("2021-01-03", "less than equal to 100"),
("2021-01-04", "101 to 300"),
("2021-01-05", "greater than 300");

SET SQL_SAFE_UPDATES = 0;
UPDATE sales
SET bucket=
CASE
  WHEN bucket = '101 to 300' THEN 'Средний заказ'
  WHEN bucket = 'less than equal to 100' THEN 'Маленький заказ'
  WHEN bucket = 'greater than 300' THEN 'Большой заказ' 
END;

select * FROM sales;


DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
employeeid VARCHAR (50) NOT NULL,
amount DECIMAL(5,2) NOT NULL,
orderstatus VARCHAR (50) NOT NULL
);
INSERT INTO orders (employeeid, amount, orderstatus)
VALUES 
("e03", '15.00', "OPEN"),
("e01", '25.50', "OPEN"),
("e05", '100.70', "CLOSED"),
("e02", '22.18', "OPEN"),
("e04", '9.50', "CANCELLED"),
("e04", '99.99', "OPEN");

SELECT id, orderstatus,
CASE 
WHEN orderstatus = 'OPEN' THEN 'Order is in open state' 
WHEN orderstatus = 'CLOSED' THEN 'Order is closed'
ELSE 'Order is CANCELLED'
END AS order_summary
    from orders;
select * from orders;