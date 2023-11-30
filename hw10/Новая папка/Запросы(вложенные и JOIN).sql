use wartunder;

select a.nickname, a.email, at2.technics_id 
from 
accounts a 
join
accounts_technics at2 
on a.id = at2.accounts_id 



-- ПОКАЗАТЬ НИКНЕЙМ АККАУНТА И ТЕХНИКУ АККАУНТА
-- ВЛОЖЕННЫЙ ЗАПРОС
select 
accounts_id,
(select nickname from accounts where id = accounts_technics.accounts_id) as name,
(select name from military_technics where id = accounts_technics.technics_id) as technics
from 
accounts_technics

-- ВЫВЕСТИ НИКНЕЙМЫ АККАУНТОВ И ВЫБОРКА ОСНОВНОВНЫХ ЗНАЧЕНИЙ И ТАБЛИЦ
-- ТЕХНИКИ, НАЦИИ И ТТХ ТАНКОВ.
-- JOIN ЗАПРОС

-- с условием по конкретному никнейму
select a.nickname, mt.name, mt.nation_id, n.nation_name, mt.military_equipment_division_id, t.damage, t.Damage_per_minute, t.armor_penetration 
from 
accounts_technics at2 
join
military_technics mt 
join 
accounts a
join
ttc t 
join 
nation n
on mt.id = at2.technics_id
and a.id = at2.accounts_id 
and t.id = mt.ttc_id 
and n.id = mt.nation_id
where a.nickname = 'ut' 

-- без условий
select a.nickname, mt.name, mt.nation_id, n.nation_name, mt.military_equipment_division_id, t.damage, t.Damage_per_minute, t.armor_penetration 
from 
accounts_technics at2 
join
military_technics mt 
join 
accounts a
join
ttc t 
join 
nation n
on mt.id = at2.technics_id
and a.id = at2.accounts_id 
and t.id = mt.ttc_id 
and n.id = mt.nation_id


-- ОБНОВИТЬ КОШЕЛЁК АККАУНТА
update wallet 
	set total = total - (select price from tank_shop)
	where account_id in (select account_id from orders where id = last_insert_id());






