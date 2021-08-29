DROP DATABASE IF EXISTS example;
CREATE DATABASE IF NOT EXISTS example;
USE example;
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users(id SERIAL, name CHAR);
DROP DATABASE IF EXISTS sample;
CREATE DATABASE IF NOT EXISTS sample;
USE sample;
-- создаем дамп утилитой mysqldump
@include example.sql