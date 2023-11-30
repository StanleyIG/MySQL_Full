
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.


DROP DATABASE IF exists sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';



START transaction;

insert into users(name, birthday_at)
select name, birthday_at
from shop.users
where users.id = 1;

COMMIT;

-- или так

-- START transaction;

-- insert into users 
-- select * from shop.users 
-- where users.id = 1;

-- COMMIT;


-- Создайте представление, которое выводит название name 
-- товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

use shop;


prepare prd from   -- создал представление
'select
p.name as products, c.name 
from products p  
join catalogs c
on p.catalog_id = c.id'

execute prd   -- выполнил запрос представления




-- по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые 
-- календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата 
-- присутствует в исходном таблице и 0, если она отсутствует.




-- (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет 
-- устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at) values
('Геннадий', '1990-10-05', '2018-08-01'),
  ('Наталья', '1984-11-12', '2016-08-04'),
  ('Александр', '1985-05-20', '2018-08-16'),
  ('Сергей', '1988-02-14', '2018-08-17'),
  ('Сергей', '1985-05-20', '2016-09-17'),
  ('Иван', '1985-07-25', '2015-03-16');
 
 alter table users add column is_true bit default 0;
 
 
 
CREATE OR REPLACE VIEW created_at_time (created_at, resultat)   -- запрос через создание представления
AS select created_at , TIMESTAMPDIFF(YEAR, created_at, NOW()) FROM users; -- создание представления

SELECT * FROM created_at_time -- запрос
order by resultat
limit 5;

delete from users   -- удаление через сортировку по возрасту, удалена самая первая запись(устаревшая) отсортированная по убыванию возраста
order by TIMESTAMPDIFF(YEAR, created_at, NOW())
desc 
limit 1





 
















