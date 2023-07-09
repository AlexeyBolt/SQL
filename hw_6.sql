USE hw_6;

DELIMITER $$
CREATE PROCEDURE seconds_to_days(IN seconds_in INT)
BEGIN
	DECLARE days INT;
	DECLARE hours INT;
	DECLARE minutes INT;
	DECLARE seconds INT;

	SET days = FLOOR(seconds_in / (24 * 3600));
	SET hours = FLOOR(seconds_in % (24 * 3600) / 3600);
	SET minutes = FLOOR(seconds_in % 3600 / 60);
	SET seconds = seconds_in - days * (24 * 3600) - hours * 3600 - minutes * 60;

	SELECT CONCAT_WS(" ", days, "days", hours, "hours", minutes, "minutes", seconds, "seconds");
END $$
DELIMITER ;

CALL seconds_to_days(123456);

-- 2. Выведите только четные числа от 1 до 10 включительно.

DELIMITER $$
CREATE PROCEDURE numbers()
BEGIN
    DECLARE n INT default 0;
    DROP TABLE IF EXISTS nums;
    CREATE TABLE nums (n INT);

    WHILE n < 10 DO
    SET n = n + 2;
    INSERT INTO nums VALUES(n) ;
    END WHILE;

SELECT * FROM nums;
END $$
DELIMITER ;

CALL numbers();