use shop

-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select user_id, (select name from users where id = user_id), count(*) as count_order  from orders group by user_id 

select  id, name, birthday_at
from users 
where id = any(select user_id from orders group by user_id);
-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

select name from catalogs where id = (select catalog_id from products where name = 'ASUS ROG MAXIMUS X HERO') -- вариант 1

select name, (select name from catalogs where id = products.catalog_id) as catalogs from products

select name from products where catalog_id = (select id from catalogs where name = 'Процессоры') -- вариант 2

select products.name, catalogs.name
from catalogs
join products 
on catalogs.id = products.catalog_id
where products.name = 'ASUS ROG MAXIMUS X HERO'             -- варианты 3, 4

select products.name, catalogs.name
from catalogs
join products 
on catalogs.id = products.catalog_id

use flights_air
SELECT
	id,
	(SELECT name FROM cities WHERE label = flights.`from`) AS 	`from`,
	(SELECT name FROM cities c WHERE label = flights.`to`) AS `to`
FROM flights;

