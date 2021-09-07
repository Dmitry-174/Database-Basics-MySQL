DROP DATABASE vk;
CREATE DATABASE vk;

SHOW DATABASES;

-- ""
-- ''
-- ``

-- phone 89771112233 
-- Тип
-- 1. Физическое представление 
-- 2. Внешнее представление
-- 3. Набор операций

-- INT + - / *
-- VARCHAR конкатенация (слияние строк)

-- INT(11) VARCHAR(11)

-- PRIMARY KEY (уникально идент. запись в таблице) + не может быть пустым. У каждой таблицы может быть только одитн первичный ключ.
-- Ограничение целостности (логическое ограничение доменной области) 
-- 0. Ограничение типа
-- 1. NOT NULL
-- 2. UNIQUE
-- 3. Значения по умолчанию для атрибута
-- 4. Внешний ключ (ссылочную целостность)
-- 5. Перечисления (диапазон значений)
SELECT 1 FROM DUAL;
SELECT 1;
SELECT NOW();
SELECT current_timestamp();

USE vk;

DROP TABLE users;

SHOW TABLES;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', -- искуственный ключ
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',  -- email + phone - натуральный ключ
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT 'Таблица пользователей';

SELECT REGEXP_LIKE('+79991234567', '^\\+7[0-9]{10}$');

ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY gender ENUM('M', 'F') NOT NULL COMMENT 'Пол'; 
ALTER TABLE users MODIFY phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя'; 
ALTER TABLE users DROP CONSTRAINT сheck_phone;
ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ; -- пользвательское правило

DESCRIBE users;

-- email phone

-- имя_атрибута тип_атрибута ОЦ
-- id SERIAL PRIMARY KEY
-- SERIAL - INT UNSIGNED NOT NULL AUTO_INCREMENT

CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	city VARCHAR(100) COMMENT 'Город проживания',
    country VARCHAR(100) COMMENT 'Старана проживания',    
    `status` VARCHAR(10) COMMENT 'Текущий статус',
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT "Таблица профилей";

ALTER TABLE profiles MODIFY `status` ENUM('Online', 'Offline', 'Inactive') NOT NULL; 

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:1
-- users <- profiles 

-- n:n
DROP TABLE friendship;
CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type_id INT UNSIGNED NOT NULL COMMENT 'Тип запроса',
    requested_at DATETIME COMMENT 'Время отправки приглашения',
    confirmed_at DATETIME COMMENT 'Время подтверждения приглашения',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки',
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
); 

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:n
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); -- 1:n

ALTER TABLE friendship DROP COLUMN request_type;
ALTER TABLE friendship ADD COLUMN request_type_id  INT UNSIGNED NOT NULL COMMENT 'Тип запроса';

ALTER TABLE friendship MODIFY requested_at DATETIME NOT NULL COMMENT 'Время отправки приглашения'; 

DESCRIBE friendship;

-- Cвязи
-- 1. Через внешний ключ. Внешний ключ всегда связывает одно поле таблицы с другим полем другой таблицы. 1:1, 1:n
-- 2. Через таблицу связи n:n

-- Алгоритм
-- 1. Создаем первую широкую сущность (основная/основные сущности домменной области)
-- 2. Нормалируем исходные сущности
-- 3. Связываем сущности
-- 4. Определяем первичный ключ
-- 5. Создаем остальные ОЦ
-- 6. GO TO 1 (Пытаемся описать новый функционал в рамках существующих сущностей)

-- user_id, friend_id 

CREATE TABLE friendship_request_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Типы запроса на дружбы";

-- имя-таблицы_имя-поля
ALTER TABLE friendship ADD CONSTRAINT friendship_request_type_id FOREIGN KEY (request_type_id) REFERENCES friendship_request_types(id); 

SHOW TABLES;
RENAME TABLE community_id TO communities;
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Группы";

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Участники групп, связь между пользователями и группами";

ALTER TABLE communities_users DROP CONSTRAINT communities_community_id;
ALTER TABLE communities_users ADD CONSTRAINT communities_community_id FOREIGN KEY (community_id) REFERENCES communities(id); 
ALTER TABLE communities_users ADD CONSTRAINT communities_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

ALTER TABLE messages ADD CONSTRAINT messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id); 

DROP TABLE media;
CREATE TABLE media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	filename VARCHAR(255) NOT NULL COMMENT "Полный путь к файлу",
    media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип файла",
    metadata JSON NOT NULL COMMENT "Метаданные файла (дополнительные параметры, переменного числа в вазисимости от типа файла)",
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
	created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

ALTER TABLE media ADD CONSTRAINT media_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id); 
ALTER TABLE media ADD CONSTRAINT media_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

/*
размер длительность разрешение кодек 

file = {
	"size":"...",
    "extension":"...",
    "resolution":"...",
    "time":"..."
}

file.size

*/

SELECT JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32') AS `JSON`;
SELECT JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32')->"$.size";

CREATE TABLE test_json (body JSON);

INSERT test_json (body) VALUES (JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32'));
SELECT * FROM test_json;
SELECT body->"$.size" FROM test_json;

INSERT test_json (body) VALUES (JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32'));
INSERT test_json (body) VALUES (JSON_OBJECT('name', 'John', 'age', '31', 'gender', 'm'));

/*
1 + 1
"1" + "1" = 2
"HELLO" + 1 = 1
*/

SELECT * FROM test_json;
DELETE FROM test_json WHERE 1=1 AND body = JSON_OBJECT('size', 123);
INSERT test_json (body) VALUES ('{"size":123, "extension": "jpeg", "resolution": "32x32"}');

drop table like_tables;
CREATE TABLE like_table (line varchar(100));
INSERT INTO like_table (line) value ('+7(999)111-22-33');
SELECT * FROM like_table WHERE line = '+7(999)111-22-33';
SELECT * FROM like_table WHERE line LIKE '+7(999)%';
INSERT INTO like_table (line) value ('Иванов Петр Борисович');
INSERT INTO like_table (line) value ('Ivanov Pert Borisovich');
SELECT * FROM like_table;
SELECT * FROM like_table WHERE line LIKE '%П__р%';

/* 
% - любое количество любых символов
_ - один любой символ
*/

SELECT REGEXP_LIKE('+79991234567', '^\\+7[0-9]{10}$');

/* 
* - любое количество любых символов (0 тоже)
+ - более одного символа
. - один любой символ
^ - начало строки
$ - конец строки
[0-9] - перечисление
\\ - экранирование
[a-z] - перечисление
{10} - сколько раз
*/

SHOW TABLES;

DROP TABLE like_table;
DROP TABLE test_json;

/* CRUD - create, read, update, delete */

SHOW TABLES;
DESCRIBE users;

USE INFORMATION_SCHEMA;
SHOW TABLES;

USE vk;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA' AND TABLE_NAME LIKE '%CONSTR%';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'vk';

SELECT * FROM users;

-- +79

-- CEIL()
-- FLOOR()
SELECT CONCAT('FOO', 'BAR');
SELECT CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND()));

SELECT REGEXP_LIKE(CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())), '^\\+7[0-9]{10}$');

UPDATE users SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;

SELECT * FROM users;

UPDATE users SET phone = CONCAT('17', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;

SELECT * FROM messages;

UPDATE messages SET
	from_user_id = FLOOR(1 + RAND() * 100),
    to_user_id = FLOOR(1 + RAND() * 100) 
     WHERE id < 200;
     
SELECT * FROM media;

DESC media;

SELECT * FROM media_types;
UPDATE media_types SET name = 'audio' WHERE id = 1;
UPDATE media_types SET name = 'image' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'gif' WHERE id = 4;
UPDATE media_types SET name = 'document' WHERE id = 5;

SELECT SUBSTR(MD5(RAND()), 1, 10);
SELECT CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10));
INSERT INTO media (filename, media_type_id, metadata, user_id) VALUE (
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    FLOOR(1 + RAND() * 5),
    '{}',
    FLOOR(1 + RAND() * 100)
);

SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}')
WHERE media_type_id = 1;

SELECT metadata->"$.size" FROM media WHERE media_type_id = 1;
UPDATE media SET filename = CONCAT_WS('.', filename, metadata->"$.extension")
WHERE media_type_id = 1;
SELECT * FROM media WHERE media_type_id = 1;

SELECT * FROM media;
SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
WHERE media_type_id = 2;


-- Дополнение функционала

-- Посты
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора поста",
  body TEXT NOT NULL COMMENT "Текст поста",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

ALTER TABLE posts ADD CONSTRAINT posts_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

-- Прикрепление медиа к посту
CREATE TABLE posts_media (
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа прикрепленное к посту",
  PRIMARY KEY (post_id, media_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Прикрепленные медиа к посту, связь между медиа и постами (многие ко многим)";

ALTER TABLE posts_media ADD CONSTRAINT posts_media_post_id FOREIGN KEY (post_id) REFERENCES posts(id); 
ALTER TABLE posts_media ADD CONSTRAINT posts_media_media_id FOREIGN KEY (media_id) REFERENCES media(id); 

-- Лайки
-- Лайки к медиа
CREATE TABLE likes_media (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя поставившего лайк",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа, которому поставили лайк",
  PRIMARY KEY (user_id, media_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки к медиа, создание таблицы лайков для медиа";

ALTER TABLE likes_media ADD CONSTRAINT likes_media_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE likes_media ADD CONSTRAINT likes_media_media_id FOREIGN KEY (media_id) REFERENCES media(id); 

-- Лайки к постам
CREATE TABLE likes_posts (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя поставившего лайк",
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост, которому поставили лайк",
  PRIMARY KEY (user_id, post_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки к постам, создание таблицы лайков для постов";

ALTER TABLE likes_posts ADD CONSTRAINT likes_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE likes_posts ADD CONSTRAINT likes_posts_post_id FOREIGN KEY (post_id) REFERENCES posts(id); 

-- Лайки к пользователям (такое вообще есть?)
CREATE TABLE likes_users (
  setter_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя поставившего лайк",
  getter_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, которому поставили лайк",
  PRIMARY KEY (setter_user_id, getter_user_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки к постам, создание таблицы лайков для постов";

ALTER TABLE likes_users ADD CONSTRAINT likes_users_setter_user_id FOREIGN KEY (setter_user_id ) REFERENCES users(id); 
ALTER TABLE likes_users ADD CONSTRAINT likes_users_getter_user_id FOREIGN KEY (getter_user_id) REFERENCES users(id); 

