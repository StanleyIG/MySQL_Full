use vk;
select distinct  firstname from users order by firstname; сортировка по алфавиту уникальных имен из таблицы users

use vk;
select user_id, birthday, 
       (YEAR(CURRENT_DATE)-YEAR(`birthday`))-(RIGHT(CURRENT_DATE,5)<RIGHT(`birthday`,5)) as age
       from profiles where (YEAR(CURRENT_DATE)-YEAR(`birthday`))-(RIGHT(CURRENT_DATE,5)<RIGHT(`birthday`,5)) < 18 
       and is_active=true; 
       

UPDATE profiles
SET is_active = 0
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)) < 18
; 

ALTER TABLE profiles ADD age bigint(5); -- добавляю колонку с возрастом age 
UPDATE profiles
SET age = YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) - (RIGHT(CURRENT_TIMESTAMP, 5) < RIGHT(birthday, 5)); -- вывожу в колонку age возраст пользователя


-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

UPDATE messages
	SET created_at='2025-11-24 08:00:00'
	WHERE id = 1 -- поставил для сообщения 1 дату из будующего
	
-- удаляю сообщения из будующего
DELETE FROM messages
WHERE created_at > now();


