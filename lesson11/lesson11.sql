/* 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
 идентификатор первичного ключа и содержимое поля name.*/ 

DROP DATABASE lesson11;
CREATE DATABASE lesson11;
USE lesson11;
   
 CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина' ENGINE=InnoDB;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

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


 CREATE TABLE logs (
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  table_id INT UNSIGNED,
  name VARCHAR(255))  ENGINE=Archive;
  
DELIMITER //
CREATE TRIGGER write_log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, table_id, name) VALUES ('catalogs', NEW.id, NEW.name);
END//

DELIMITER //
CREATE TRIGGER write_log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, table_id, name) VALUES ('users', NEW.id, NEW.name);
END//

DELIMITER //
CREATE TRIGGER write_log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, table_id, name) VALUES ('products', NEW.id, NEW.name);
END//

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12');

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы');
  
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1);
  
SELECT * FROM logs; 
 
 /* 2. Создайте SQL-запрос, который помещает в таблицу users миллион записей. */ 

-- При помощи цикла
TRUNCATE users; 
DELIMITER //
CREATE PROCEDURE mass_insert(num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	REPEAT
		INSERT INTO users (name, birthday_at) VALUES (SUBSTR(MD5(RAND()), 1, 10), '1990-10-05');
		SET i = i + 1;
		UNTIL i >= num
    END REPEAT;
END//
CALL mass_insert(1000000); -- Ооооочень долго!!! Больше 10 минут
SELECT count(1) FROM lesson11.users; 


-- При помощи join
TRUNCATE users; 
CREATE TABLE samples (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO samples (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29'),
  ('Антон', '1990-10-05'),
  ('Павел', '1984-11-12'),
  ('Михаил', '1985-05-20'),
  ('Константин', '1988-02-14');

INSERT INTO users (name, birthday_at) 
SELECT fst.name, fst.birthday_at FROM samples as fst
CROSS JOIN samples as snd
CROSS JOIN samples as trd
CROSS JOIN samples as fth
CROSS JOIN samples as fif
CROSS JOIN samples as sth; -- 27 секунд

