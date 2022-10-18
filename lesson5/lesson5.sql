/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем. */

CREATE DATABASE IF NOT EXISTS lesson5;
USE lesson5;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
UPDATE users SET created_at = NOW(), updated_at = NOW() WHERE id < 10;

/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и
 в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля 
 к типу DATETIME, сохранив введённые ранее значения. */
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '10.09.2021 8:10', '10.09.2021 8:15'),
  ('Наталья', '1984-11-12', '10.09.2021 8:20', '10.09.2021 8:20'),
  ('Александр', '1985-05-20', '11.09.2021 8:10', '12.09.2021 8:15'),
  ('Сергей', '1988-02-14', '12.09.2021 8:10', '12.09.2021 13:15'),
  ('Иван', '1998-01-12', '10.09.2021 12:10', '10.09.2021 13:15'),
  ('Мария', '1992-08-29', '11.09.2021 12:10', '12.09.2021 13:15');
  
UPDATE users SET created_at = STR_TO_DATE(created_at,'%d.%m.%Y %H:%i'), 
	updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %H:%i') WHERE id < 10;

ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP;
DESCRIBE users;

/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, 
после всех записей.
 */
 
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1, 1, 100),
  (2, 1, 0),
  (2, 2, 54),
  (2, 3, 23),
  (1, 3, 21),
  (1, 2, 0);
  
SELECT * FROM storehouses_products ORDER BY IF(value != 0, 0, 1), value;

/* 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий (may, august)
 */
 
 SELECT * FROM users where date_format(birthday_at, '%M') IN ('may', 'august');
 
 
 /* 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 Отсортируйте записи в порядке, заданном в списке IN. */
 DROP TABLE catalogs;
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

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY 
	CASE 
		WHEN id = 5 THEN 0
		WHEN id = 1 THEN 1
		ELSE 2
	END, id;
    
-- Практическое задание теме «Агрегация данных»
-- 1. Подсчитайте средний возраст пользователей в таблице users.

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, now())) AS avg FROM users;

/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 Следует учесть, что необходимы дни недели текущего года, а не года рождения. */ 
 
SELECT DATE_FORMAT(DATE(CONCAT(YEAR(NOW()), DATE_FORMAT(birthday_at,'-%m-%d'))), '%a') AS day_of_week, 
COUNT(*) AS birthdays FROM users GROUP BY day_of_week;

-- 3. Подсчитайте произведение чисел в столбце таблицы

CREATE TABLE task3 (value INT);
INSERT INTO task3 VALUES (1), (2), (3), (4), (5);
SELECT ROUND(exp(SUM(ln(value))), 0) AS prod FROM task3;