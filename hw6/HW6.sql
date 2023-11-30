
use vk
-- 2) узнать общее колличество лайков которые получили пользователи младше 10 лет
select count(*) from likes 
where media_id in(select id from media 
where user_id in(
select user_id from profiles 
where TIMESTAMPDIFF(year, birthday, now()) < 10))

-- правельный вариант, так как руководствоваться надо таблицей медиа, которая заполняется первой и куда 
-- изначально заносится информация о юзере айди
select count(*) from likes 
where media_id in(select id from media 
where user_id in(select user_id from profiles as p
where TIMESTAMPDIFF(year, birthday, now()) < 10)) 

-- не совсем правильный вариант, т.к. может быть расхождение с таблицей медиа, по колличеству лайков. Возможно исключить колонку user_id
-- и оставить только id, media_id и created_at. 
select count(*) from likes
where user_id in(select user_id from profiles where TIMESTAMPDIFF(year, birthday, now()) < 10) group by user_id 

-- 3) узнать кто из пользователей получил больше лайков мужчины или женщины
-- неправельное решение, потому запрос даст уникальные значение из таблицы профиль.
select count(*), gender
from profiles where user_id in(select user_id from likes)
group by gender order by gender desc;

-- правельные варианты, потому что теперь значения выбираются из таблицы лайков в которой юзерайди равные юзерайди из профиля могут повторятся
-- по нескольку раз. 
-- вар. 1
select count(*) , (select gender from profiles where user_id = likes.user_id) as gender from likes group by gender limit 1
-- вар. 2
select gender, count(*) from (select user_id as user, (select gender from vk.profiles where user_id = user) as gender from likes) as dummy
group by gender
limit 1;

-- 1) найти спамера (кто больше всех писал сообщений выбранному пользователю "6")
select count(*), from_user_id, (select firstname from users where id = from_user_id) as name, to_user_id  
from messages where to_user_id = 7 
group by from_user_id 

select initiator_user_id, target_user_id  from friend_requests where (initiator_user_id = 3 or target_user_id = 3) and status = 'approved'

-- определяю друзей у пользователя с id 3
select initiator_user_id from friend_requests where (target_user_id = 3) and status = 'approved'
union 
select target_user_id  from friend_requests where (initiator_user_id = 3) and status = 'approved'


-- показать кто "из друзей" написал больше всех сообщений выбранному полльзователю. Вариант 1
select from_user_id, to_user_id from messages
where from_user_id = any(select initiator_user_id from friend_requests where (target_user_id = 10) and status = 'approved'
union 
select target_user_id from friend_requests where (initiator_user_id = 10) and status = 'approved')
and to_user_id = 10
group by from_user_id 

-- Вариант 2 с вложенным запросом имени
select count(*), from_user_id, (select concat(firstname, ' ', lastname) from users where id = messages.from_user_id) as name, to_user_id from messages
where from_user_id = any(select initiator_user_id from friend_requests where (target_user_id = 3) and status = 'approved'
union 
select target_user_id from friend_requests where (initiator_user_id = 3) and status = 'approved')
and to_user_id = 3
group by from_user_id 


select count(*), user_id  from media group by user_id -- колличество новостей у каждого пользователя

-- update likes 
-- set user_id = user_id in(select user_id from media)

update media 
set media_type_id = 3 where id = any (select media_id from photos); -- обновил медиатипы которые относятся к media_id к таблице фото.



 



  