-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

use shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (table_name VARCHAR(20) not null, 
id_table int not null, 
name VARCHAR(20) not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP)
ENGINE=Archive;

DELIMITER //
CREATE TRIGGER insert_logs_catalogs
after insert on catalogs
FOR each row
begin
     insert into logs(table_name, id_table, name)
     values ('catalogs', new.id, new.name);
end//
DELIMITER ;

insert into catalogs(name) values
('корпусы');
select * from logs l;

insert into catalogs(name) values
('куллеры');
select * from logs l;

DELIMITER //
CREATE TRIGGER insert_logs_users
after insert on users
FOR each row
begin
     insert into logs(table_name, id_table, name)
     values ('users', new.id, new.name);
end//
DELIMITER ;

insert into users(name, birthday_at) values
('Дормидон', '1992-09-28');
select * from logs l;

insert into users(name, birthday_at) values
('Афоня', '1991-12-15');
select * from logs l;


DELIMITER //
CREATE TRIGGER insert_logs_products
after insert on products
FOR each row
begin
     insert into logs(table_name, id_table, name)
     values ('products', new.id, new.name);
end//
DELIMITER ;

insert into products(name) values
('AERO COOL A5');
select * from logs l;

insert into products(name) values
('COLLER MASTER');
select * from logs l;




-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
use shop;
DROP TABLE IF EXISTS samples;
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
  ('Антон', '1991-04-20'),
  ('Андрей', '1993-05-15'),
  ('Алексей', '1990-9-10'),
  ('Дормидон', '1994-07-20');
 
select count(*) from samples s, 
samples s2, 
samples s3, 
samples s4, 
samples s5, 
samples s6; 

 select count(*) -- тоже самое, но вместо запятой join. Если не указать условие объединения on, то для каждой строки будет выведено 
 from samples s  -- следующие 10 строк, а для следующих 100 ещё по 10 на каждую и тогда будет 1000 и т.д.
 join samples s2 -- оператор join осуществляет декартовое произведение таблиц.
 join samples s3 
 join samples s4 
 join samples s5 
 join samples s6;



INSERT INTO users (name, birthday_at)
select s.name, s.birthday_at 
from 
samples s, 
samples s2, 
samples s3, 
samples s4, 
samples s5, 
samples s6; 
 















