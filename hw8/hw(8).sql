
-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. Через JOIN
use shop

SELECT users.id, users.name, users.birthday_at, orders.created_at FROM users
JOIN orders ON users.id = orders.user_id;

-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.

select products.name, catalogs.name
from catalogs
join products 
on catalogs.id = products.catalog_id

 -- узнать общее колличество лайков которые получили пользователи младше 10 лет
use vk

SELECT COUNT(*) 
FROM likes l 
join media m 
on l.media_id = m.id
where m.user_id in(select user_id from profiles where TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10)

-- 3) узнать кто из пользователей получил больше лайков  мужчины или женщины

select count(*), p.gender 
from likes l
join profiles p  
on p.user_id = l.user_id
group by gender

-- СДЕЛАТЬ ИСПОЛЬЗУЯ JOIN 

-- кто из всех пользователей написал больше всех сообщений выбранному пользователю
select count(*) as cnt, concat(u.firstname, ' ', u.lastname) as first_last, m.to_user_id 
from users u 
join messages m
on u.id = m.from_user_id 
where m.to_user_id = 6
group by u.id    -- можно group by first_last
order by cnt     -- сортирую по величине в данном случае
desc             -- переворачиваю, т.к. самое большее кол-во находится внизу
limit 1          -- вырезаю только первую строку



-- показать кто "из друзей" написал больше всех сообщений выбранному полльзователю. Сделать через JOIN
select count(*) as cnt_msg, fr.target_user_id, m.to_user_id  
from friend_requests fr 
join messages m 
on fr.target_user_id = m.from_user_id  
where (fr.status = 'approved' and fr.initiator_user_id = 10) and m.to_user_id = 10
group by fr.target_user_id 
union all
select count(*) as cnt_msg, fr.initiator_user_id, m.to_user_id  
from friend_requests fr 
join messages m 
on fr.initiator_user_id = m.from_user_id 
where (fr.status = 'approved' and fr.target_user_id  = 10) and m.to_user_id = 10
group by fr.initiator_user_id









