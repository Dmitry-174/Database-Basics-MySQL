/* Практическое задание по теме “Транзакции, переменные, представления”
1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/
 
-- Создадим базы данных shop и sample, таблицу shop.users и структуру таблицы sample.users
CREATE DATABASE shop;
USE shop;
 
 CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  

CREATE DATABASE sample;
USE sample;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users, используя транзакции.
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;
  
/* 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и 
соответствующее название каталога name из таблицы catalogs. */

USE shop;

CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
  
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

CREATE VIEW product_catalog (product, catalog)
AS 
	SELECT products.name, catalogs.name FROM products
	LEFT JOIN catalogs
	ON products.catalog_id = catalogs.id;
    
SELECT * FROM product_catalog;

/* 3. по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные 
записи за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который 
выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном 
таблице и 0, если она отсутствует. */ 

CREATE TABLE august (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATE);
    
INSERT INTO august (name, created_at) VALUES
  ('Геннадий', '2018-08-01'),
  ('Наталья', '2018-08-04'),
  ('Александр', '2018-08-16'),
  ('Сергей', '2018-08-17');
  
CREATE TABLE august_days (
	id SERIAL PRIMARY KEY,
	day DATE);
  
INSERT INTO august_days (day) VALUES
	('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'),
	('2018-08-06'), ('2018-08-07'), ('2018-08-08'), ('2018-08-09'), ('2018-08-10'),
	('2018-08-11'), ('2018-08-12'), ('2018-08-13'), ('2018-08-14'), ('2018-08-15'),
	('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20'),
	('2018-08-21'), ('2018-08-22'), ('2018-08-23'), ('2018-08-24'), ('2018-08-25'),
	('2018-08-26'), ('2018-08-27'), ('2018-08-28'), ('2018-08-29'), ('2018-08-30'),
	('2018-08-31');
 
 SELECT august_days.day, NOT ISNULL(august.created_at) FROM august_days
 LEFT JOIN august
 ON august_days.day = august.created_at
 ORDER BY august_days.day;
 
/* 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

TRUNCATE TABLE august;

INSERT INTO august (name, created_at) VALUES
  ('Геннадий', '2018-08-01'),
  ('Наталья', '2018-08-04'),
  ('Александр', '2018-08-16'),
  ('Сергей', '2018-08-17'),
  ('Дмитрий', '2018-08-02'),
  ('Павел', '2018-08-20'),
  ('Антон', '2018-08-22'),
  ('Станислав', '2018-08-28');
 
SELECT count(1) - 5 FROM august INTO @num;
PREPARE del_request FROM 'DELETE FROM august ORDER BY created_at LIMIT ?';
EXECUTE del_request USING @num;

SELECT * FROM august;

/* Практическое задание по теме “Хранимые процедуры и функции, триггеры"
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
 фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/

DELIMITER //
CREATE FUNCTION hello(cur_time TIME)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE hello_type VARCHAR(255);
	CASE
		WHEN (cur_time BETWEEN '06:00' AND '12:00') THEN
		SET hello_type = 'Доброе утро';
		WHEN (cur_time BETWEEN '12:00' AND '18:00') THEN
		SET hello_type = 'Добрый день';
		WHEN (cur_time BETWEEN '18:00' AND '24:00') THEN
		SET hello_type = 'Добрый вечер';
		ELSE
		SET hello_type = 'Доброй ночи';
    END CASE;
    RETURN hello_type;
END//

SELECT hello('23:59');
SELECT hello('05:59');
SELECT hello('06:00');
SELECT hello('12:00');
SELECT hello('18:00');

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были 
заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

DELIMITER //
CREATE TRIGGER check_name_or_description BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF (NEW.name IS NOT NULL OR NEW.description IS NOT NULL) THEN
	SET NEW.name = NEW.name;
	SET NEW.description = NEW.description;
  ELSE
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
  END IF;
END//

DELIMITER //
CREATE TRIGGER check_name_or_description_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF (NEW.name IS NOT NULL OR NEW.description IS NOT NULL) THEN
	SET NEW.name = NEW.name;
	SET NEW.description = NEW.description;
  ELSE
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
  END IF;
END//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7777.00, 1);
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('TEST name', NULL, 7777.00, 1);
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, NULL, 7777.00, 1);
  
UPDATE products SET name = NULL WHERE id = 9;

/* 3. по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55.*/

DELIMITER //
CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE FIB INT;  -- текущее число фибоначи
	DECLARE FIB0 INT; -- число фибоначи на 2 позиции ранее текущего
	DECLARE FIB1 INT; -- число фибоначи на 1 позицию ранее текущего
    DECLARE i INT DEFAULT 1;
	IF (num = 0 OR num = 1) THEN
		SET FIB = num;
	ELSE
		SET FIB0 = 0;
        SET FIB1 = 1;
			REPEAT
			SET FIB = FIB0 + FIB1;
			SET FIB0 = FIB1;
            SET FIB1 = FIB;
            SET i = i + 1;
			UNTIL i >= num
		END REPEAT;
    END IF;
    RETURN FIB;
END//

SELECT FIBONACCI(10);
SELECT FIBONACCI(9);
SELECT FIBONACCI(0);
SELECT FIBONACCI(1);