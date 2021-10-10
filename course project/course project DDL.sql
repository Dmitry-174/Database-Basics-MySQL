CREATE DATABASE IF NOT EXISTS booking;
USE booking;
 
 CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
  surname VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
  email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Электронная почта пользователя',
  phone VARCHAR(14) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
  birthday_at DATE NOT NULL COMMENT 'Дата рождения пользователя',
  sex ENUM('male', 'female') COMMENT 'Пол пользователя',
  account_type ENUM('owner', 'travaler') COMMENT 'Тип аккаунта', -- Владелец объекта размещения или путешественник
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';
-- Проверка формата номера '+<код страны 1-3 цифры><номер телефона 10 цифр>'
ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+[0-9]{1,3}[0-9]{10}$')); 


CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL UNIQUE PRIMARY KEY,
    country VARCHAR(100) NOT NULL COMMENT 'Старана проживания', 
    city VARCHAR(100) COMMENT 'Город проживания',
    postcode VARCHAR(10) COMMENT 'Индекс для доставки корреспонденции',
    address VARCHAR(255) COMMENT 'Адрес выставления счета',
    currency_id INT NOT NULL DEFAULT 1 COMMENT 'Ссылка на валюту пользователя, по умолчанию 1 (USD)',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Профили пользователей';
ALTER TABLE profiles MODIFY COLUMN currency_id INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Ссылка на валюту пользователя, по умолчанию 1 (USD)';

ALTER TABLE profiles ADD CONSTRAINT profiles_users_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:1

CREATE TABLE properties(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	property_name VARCHAR(255) NOT NULL COMMENT 'Название объекта размещения',
    property_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип объекта размещения',
    country VARCHAR(100) COMMENT 'Старана объекта размещения', 
    city VARCHAR(100) COMMENT 'Город объекта размещения',
    postcode VARCHAR(10) COMMENT 'Индекс объекта размещения',
    address VARCHAR(255) COMMENT 'Адрес объекта размещения',
    currency_id INT NOT NULL DEFAULT 1 COMMENT 'Ссылка на валюту объекта размещения, по умолчанию 1 (USD)',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Объекты размещения';
ALTER TABLE properties MODIFY COLUMN currency_id INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Ссылка на валюту объекта размещения, по умолчанию 1 (USD)';

CREATE TABLE currencies(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	currency_name VARCHAR(255) NOT NULL COMMENT 'Название валюты',
    currency_code VARCHAR(3) COMMENT 'Код валюты',
    exchange_rate_to_usd DECIMAL(8,4) COMMENT 'Курс к доллару',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Валюты';


CREATE TABLE property_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    property_type VARCHAR(255) NOT NULL COMMENT 'Тип объекта размещения',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Типы объектов размещения';

ALTER TABLE properties ADD CONSTRAINT properties_property_type_id FOREIGN KEY (property_type_id) REFERENCES property_types(id); -- 1:1
ALTER TABLE properties ADD CONSTRAINT properties_currency_id FOREIGN KEY (currency_id) REFERENCES currencies(id); -- 1:1
ALTER TABLE profiles ADD CONSTRAINT profiles_currency_id FOREIGN KEY (currency_id) REFERENCES currencies(id); -- 1:1

/* Создание таблицы связи аккаунтов собственников (users) и объектов размещения (properties)
Связь n:n, так как у одного собственника может быть несколько отелей (сеть отелей)
так и доступ к управлению объектом размещения может быть у нескольких аккаунтов собственников 
(совладельцы, администраторы, управляющие) */

-- !!!Добавить тригер на проверку типа аккаунта!!!bookings
CREATE TABLE owners_properties (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на аккаун собственника",
  property_id INT UNSIGNED NOT NULL COMMENT "Ссылка на объект размещения",
  PRIMARY KEY (user_id, property_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица связи аккаунтов собственников и объектов размещения";

ALTER TABLE owners_properties ADD CONSTRAINT owners_properties_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE owners_properties ADD CONSTRAINT owners_properties_property_id FOREIGN KEY (property_id) REFERENCES properties(id);

CREATE TABLE room_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
    room_type VARCHAR(255) NOT NULL COMMENT 'Тип номера',
    guests INT UNSIGNED NOT NULL COMMENT 'Вместимость номера',
    additonal_children INT UNSIGNED NOT NULL COMMENT 'Скольких детей дополнительно возможно разместить',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Типы номеров';

/* Создание таблицы связи объектов размещения (properties) и типов номеров (room_types)
Связь n:n, так как в одном отеле могут быть, например, двухметсные стандартные номера, 
трехместные люксы и т.д.
так и одинаковые типы номеров могут быть в разных отелях */

CREATE TABLE properties_rooms(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  property_id INT UNSIGNED NOT NULL COMMENT "Ссылка на объект размещения",
  room_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип номера",
  room_size INT UNSIGNED NOT NULL COMMENT "Площадь номера данного типа в данном объекте размещения",
  price INT UNSIGNED NOT NULL COMMENT "Стоимость за ночь в валюте объекта размещения",
  quantity INT UNSIGNED NOT NULL COMMENT "Количество номеров данного типа в данном объекте размещения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица связи типов номеров и объектов размещения";
ALTER TABLE properties_rooms MODIFY COLUMN price FLOAT UNSIGNED NOT NULL COMMENT "Стоимость за ночь в валюте объекта размещения";

ALTER TABLE properties_rooms ADD CONSTRAINT properties_rooms_property_id FOREIGN KEY (property_id) REFERENCES properties(id);
ALTER TABLE properties_rooms ADD CONSTRAINT properties_rooms_room_type_id FOREIGN KEY (room_type_id) REFERENCES room_types(id);


CREATE TABLE reviews(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  property_id INT UNSIGNED NOT NULL COMMENT "Ссылка на объект размещения",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на путешественника",
  rating INT UNSIGNED NOT NULL COMMENT "Оценка от 1 до 10",
  benefits TEXT COMMENT "Описание преимуществ",
  disadvantages TEXT COMMENT "Описание недостатков",
  is_moderated BOOLEAN COMMENT "Прошло проверку модератора",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Отзывы";

ALTER TABLE reviews ADD CONSTRAINT сheck_rating CHECK (rating >= 1 OR rating <=10); 
ALTER TABLE reviews ADD CONSTRAINT reviews_property_id FOREIGN KEY (property_id) REFERENCES properties(id);
ALTER TABLE reviews ADD CONSTRAINT reviews_user_id FOREIGN KEY (user_id) REFERENCES users(id);

CREATE TABLE meals(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  meal_type VARCHAR(255) NOT NULL COMMENT 'Название типа питания',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы питания";

/* Создание таблицы связи объектов размещения (properties) и типов питания (meals)
Связь n:n, так как в одном отеле могут быть предложены различные типы питания, например, завтрак, 
завтрак и ужин, всё включено и т.д. по определенной цене для отеля
так и одинаковые типы питания могут быть в разных отелях */

CREATE TABLE properties_meals(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  property_id INT UNSIGNED NOT NULL COMMENT "Ссылка на объект размещения",
  meal_type_id INT UNSIGNED NOT NULL DEFAULT 1 COMMENT "Ссылка на тип питания, по умолчанию тип 1 (без питания)",
  price INT UNSIGNED NOT NULL COMMENT "Стоимость за ночь проживания в валюте объекта размещения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица связи типов питания и объектов размещения";
ALTER TABLE properties_meals MODIFY COLUMN price FLOAT UNSIGNED NOT NULL COMMENT "Стоимость за ночь в валюте объекта размещения";

ALTER TABLE properties_meals ADD CONSTRAINT properties_meals_property_id FOREIGN KEY (property_id) REFERENCES properties(id);
ALTER TABLE properties_meals ADD CONSTRAINT properties_meals_meal_type_id  FOREIGN KEY (meal_type_id) REFERENCES meals(id);

CREATE TABLE bookings(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
  properties_rooms_id INT UNSIGNED NOT NULL COMMENT "Ссылка на номер в объекте размещения",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на путешественника",
  check_in_date DATE NOT NULL COMMENT "Дата прибытия",
  nights INT UNSIGNED NOT NULL COMMENT "Количество забронированных ночей",
  guests INT UNSIGNED NOT NULL COMMENT "Количество гостей",
  children INT UNSIGNED NOT NULL DEFAULT 0 COMMENT "Дополнительно количество детей",
  meal_type_id INT UNSIGNED NOT NULL DEFAULT 1 COMMENT "Ссылка на тип питания, по умолчанию тип 1 (без питания)",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Бронирования";

ALTER TABLE bookings ADD CONSTRAINT bookings_properties_rooms_id FOREIGN KEY (properties_rooms_id) REFERENCES properties_rooms(id);
ALTER TABLE bookings ADD CONSTRAINT bookings_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE bookings ADD CONSTRAINT bookings_meal_type_id FOREIGN KEY (meal_type_id) REFERENCES meals(id);

-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)

-- 1. Вывести среднюю стоимость номера в USD в каждом городе, вывести в порядке убывания цены

SELECT city, AVG(price * exchange_rate_to_usd) as avg_price FROM properties
INNER JOIN properties_rooms
ON property_id = properties.id
INNER JOIN currencies
ON currencies.id = properties.currency_id
GROUP BY city
ORDER BY avg_price DESC;

-- 2 вывести список объектов размещения с рейтингом больше 8 
SELECT property_name, avg_rating FROM (
	SELECT property_name, AVG(rating) as avg_rating FROM properties
	INNER JOIN reviews
	ON properties.id = property_id 
	GROUP BY property_id
	) AS properties_rating_more_8
WHERE avg_rating > 8;

-- 3 Вывести список отелей (тип объекта размещения - отель) у которых пока нет отзывов
SELECT property_name FROM properties
WHERE id NOT IN (SELECT property_id FROM reviews) AND property_type_id = 2; 

-- 4 Вывести список пользователей и названий объектов размещения, которым ставили оценки меньше 3
SELECT name, surname, property_name, rating FROM users
INNER JOIN reviews
ON users.id = user_id
INNER JOIN properties
ON properties.id = property_id
WHERE rating < 3;

-- 5 Вывести список объектов размещения в Палестине, которые предоставляют тип питания Всё включено.
SELECT property_name FROM properties
INNER JOIN properties_meals
ON property_id = properties.id
WHERE country = 'Palestinian Territory' AND meal_type_id = 5;

-- Представления
-- 1. Создать представление списка из названий объектов размещения, их рейтинга и города размещения в порядке убывания рейтинга

CREATE OR REPLACE VIEW rating AS
SELECT property_name, AVG(rating) as avg_rating, city FROM properties
INNER JOIN reviews
ON properties.id = property_id 
GROUP BY property_id
ORDER BY avg_rating DESC;

SELECT * FROM rating;
	
-- 2 Создать представление на основе таблицы properties состоящей из только отелей
CREATE OR REPLACE VIEW hotels AS
SELECT property_name, country, city, address FROM properties
WHERE property_type_id = 2;

SELECT * FROM hotels;

-- хранимые процедуры / триггеры;
-- 1. Процедура выводит стоимость бронирования в валюте клиента за весь срок проживания по id бронирования

DROP PROCEDURE booking_cost;
DELIMITER //
CREATE PROCEDURE booking_cost(b_id INT)
BEGIN
	DECLARE pr_id, mt_id, u_id, ns, adults, chldrn, prop_id INT;
    DECLARE meal_price, room_price, full_price_usd, full_price_user FLOAT;
    DECLARE ex_rate_prop, ex_rate_user DECIMAL(8,4);
    -- Выберем исходные данные по id бронирования
	SELECT properties_rooms_id, meal_type_id, user_id, nights, guests, children 
    INTO pr_id, mt_id, u_id, ns, adults, chldrn FROM bookings WHERE id = b_id;
    
    -- Выберем стоимость проживание и id объекта размещения
    SELECT price, property_id INTO room_price, prop_id FROM properties_rooms WHERE id = pr_id;
    
    -- Выберем стоимость питания 
    SELECT price INTO meal_price FROM properties_meals WHERE property_id = prop_id AND meal_type_id = mt_id;
    
    -- Выберем обменный курс для валюты объекта размещения и клиента
    SELECT exchange_rate_to_usd INTO ex_rate_prop FROM currencies 
    INNER JOIN properties 
    ON currencies.id = currency_id 
    WHERE properties.id = prop_id;
    
    SELECT exchange_rate_to_usd INTO ex_rate_user FROM currencies 
    INNER JOIN profiles 
    ON currencies.id = currency_id 
    WHERE user_id = u_id;
    
    -- Произведем расчет полной стоимости бронирования в валюте клиента
    SET full_price_usd = (room_price * ns + (adults + chldrn) * meal_price) * ex_rate_prop;
    SET full_price_user = full_price_usd / ex_rate_user;
    SELECT full_price_user;
END//

CALL booking_cost(2);

/* 2. Триггер осуществляет проверку типа акканта пользователя account_type = 'owner'
перед добалением строки в таблицу owners_properties, т.к. владельцем объекта размещения может быть
пользователь с типом аккаунта owner. */

DELIMITER //
CREATE TRIGGER check_account_type BEFORE INSERT ON owners_properties
FOR EACH ROW
BEGIN
	DECLARE ac_t VARCHAR(14);
    SELECT account_type INTO ac_t FROM users WHERE id = NEW.user_id;
    IF ac_t != 'owner' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account type is invalid';
	END IF;
END //

-- Проверим работу триггера
INSERT INTO `owners_properties` (`user_id`, `property_id`, `created_at`, `updated_at`) VALUES (1, 1, NOW(), NOW());
INSERT INTO `owners_properties` (`user_id`, `property_id`, `created_at`, `updated_at`) VALUES (2, 1, NOW(), NOW());    
DELETE FROM owners_properties WHERE user_id = 2 AND property_id = 1;

-- Создадим аналогичный триггер на обновление данных
DELIMITER //
CREATE TRIGGER check_account_type_update BEFORE UPDATE ON owners_properties
FOR EACH ROW
BEGIN
	DECLARE ac_t VARCHAR(14);
    SELECT account_type INTO ac_t FROM users WHERE id = NEW.user_id;
    IF ac_t != 'owner' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account type is invalid';
	END IF;
END //
