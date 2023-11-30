DROP TABLE IF EXISTS catalogs;
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

DROP TABLE IF EXISTS users;
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


 
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
-- значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- ALTER TABLE users MODIFY COLUMN created_at varchar(150), MODIFY COLUMN updated_at varchar(150); изменяю тип данных колонки created_at
-- и updated_at на строковый

-- update users     -- обновляю колонки меняя формат времени как указано в задании
-- set created_at = date_format(created_at, '%d.%m.%Y %k:%i:%s'), 
-- updated_at = date_format(updated_at, '%d.%m.%Y %k:%i:%s');

-- UPDATE users     -- снова обновляю(возвращаю) формат даты по умолчанию с помощью функции STR_TO_DATE
-- функция принимает текущее значение которое нужно исправить и обновляет колонки в формате %Y-%m-%d %k:%i:%s
-- SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i:%s'),
-- updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i:%s');

-- ALTER TABLE users MODIFY COLUMN created_at DATETIME NULL, MODIFY COLUMN updated_at DATETIME NULL;
-- снова изменяю тип данных с строкового на DATETIME



DROP TABLE IF EXISTS products;
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

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products
	(storehouse_id, product_id, value) VALUES
	(1, 1, 2),
	(2, 2, 1),
	(3, 3, 10),
	(4, 4, 55),
	(5, 5, 60),
	(6, 6, 0)
;



-- 1) UPDATE users
	-- SET created_at = NOW(), или AND updated_at = NOW(); 1) Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
	-- Заполните их текущими датой и временем.
 
-- 2) Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
-- значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- ALTER TABLE users MODIFY COLUMN created_at varchar(150), MODIFY COLUMN updated_at varchar(150); изменяю тип данных колонки created_at
-- и updated_at на строковый

-- update users     -- обновляю колонки меняя формат времени как указано в задании
-- set created_at = date_format(created_at, '%d.%m.%Y %k:%i:%s'), 
-- updated_at = date_format(updated_at, '%d.%m.%Y %k:%i:%s');

-- UPDATE users     -- снова обновляю(возвращаю) формат даты по умолчанию с помощью функции STR_TO_DATE
-- функция принимает текущее значение которое нужно исправить и обновляет колонки в формате %Y-%m-%d %k:%i:%s
-- SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i:%s'),
-- updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i:%s');

-- ALTER TABLE users MODIFY COLUMN created_at DATETIME NULL, MODIFY COLUMN updated_at DATETIME NULL;
-- снова изменяю тип данных с строкового на DATETIME

-- 3) В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы 
-- они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

-- select value FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 9999999999999999999999 end;



-- 4) (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка 
-- английских названий ('may', 'august')

-- SELECT * FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}';

-- SELECT *
-- FROM users
-- WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august'); 

-- 5) (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в 
-- порядке, заданном в списке IN.

-- SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by field(id, 5,2,1);
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER by id=1, id=2, id=5;

-- Практическое задание теме “Агрегация данных”

-- 1)Подсчитайте средний возраст пользователей в таблице users
-- select 
--   name, 
--   round(AVG(TIMESTAMPDIFF(year, birthday_at, now()))) as AVGAGE 
-- from 
--   users;

-- SELECT 
-- SUM(DATE_FORMAT(NOW() , '%Y') - DATE_FORMAT(birthday_at, '%Y'))/COUNT(birthday_at) 
-- FROM users; 

-- 2)Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- select DAYNAME(STR_TO_DATE(CONCAT_WS('.', DATE_FORMAT(birthday_at, '%d'), DATE_FORMAT(birthday_at, '%M'), DATE_FORMAT(NOW(), '%Y')), '%d.%M.%Y')) as WD, COUNT(*)
-- from users group by WD; запарился вхлам пока делал. Вобщем с помощью CONCAT_WS() собрал день месяц и текущий год далее с помощью STR_TO_DATE привёл к формату 
-- DATETIME, далее обернул всё это дело в функцию DAYNAME(date), далее указал псевдоним WD значению и запросил колличество COUNT(*) для всех строк с 
-- группировкой group by по дням недели WD

-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы
-- select exp(sum(ln(id))) from users;



select * from storehouses_products order by if(value>0,0,1), value;
select value from storehouses_products order by if(value>0,0,1), value;
select exp(sum(ln(id))) from catalogs;