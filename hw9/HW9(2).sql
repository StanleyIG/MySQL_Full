-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
-- Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму 
-- пользователю shop — любые операции в пределах базы данных shop.


CREATE user 'shop_read'@'localhost' IDENTIFIED BY '123321';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
DROP USER shop_read;
CREATE user 'shop'@'localhost' IDENTIFIED BY '123321';
GRANT ALL ON shop.* TO 'shop'@'localhost';

-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие 
-- первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы 
-- accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы 
-- не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

DROP TABLE IF exists accaunts;
CREATE TABLE accaunts (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(50),
  `password` VARCHAR(100));
  
  insert into accaunts (user_name, `password`) 
  values
  ('Ivan', 'jhdsjf24432'), ('stepan', 'ddshdfd343243'),('sergey', 'wr3rewefe34');
 
 
 CREATE OR REPLACE VIEW username (id, name)   -- запрос через создание представления
AS select id, user_name FROM accaunts;

CREATE user 'user_read'@'localhost' IDENTIFIED BY '123321';  -- создал пользователя
GRANT SELECT (id, name) on username  TO 'user_read'@'localhost'; -- наделил правами пользователя, дал ему право читать представление
-- username таблицы accaunts

-- через командную строку зашёл к пользователю user_read и прочитал представление username
-- доступ к котрому получил у рута.

C:\Users\Админ>mysql -u user_read -p
Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 255
Server version: 8.0.30 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| performance_schema |
| sample             |
+--------------------+
3 rows in set (0.00 sec)

mysql> use sample
Database changed
mysql> select * from username
    -> ;
+----+--------+
| id | name   |
+----+--------+
|  1 | Ivan   |
|  2 | stepan |
|  3 | sergey |
+----+--------+
3 rows in set (0.00 sec)

  





