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
  meal_type VARCHAR(255) NOT NULL COMMENT 'Название объекта размещения',
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

