DROP DATABASE IF exists wartunder;
CREATE DATABASE wartunder;
USE wartunder;



DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY, 
    nickname VARCHAR(100) unique,
    email VARCHAR(100) UNIQUE,
    password_hash varchar(100),
    phone BIGINT,
    created_at DATETIME DEFAULT NOW(),
    is_deleted bit default 0,
    INDEX nickname_idx(nickname)
);

DROP TABLE IF EXISTS tank_shop;
CREATE TABLE tank_shop(
    id SERIAL PRIMARY KEY,
    technics_id BIGINT unsigned COMMENT 'id танка',
    ttc_id BIGINT unsigned COMMENT 'внешний ключ тактико технических характеристик',
    price DECIMAL(11) COMMENT 'Цена');
   

      

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  account_id BIGINT unsigned COMMENT 'аккаунт', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES accounts(id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_tank_shop;
CREATE TABLE orders_tank_shop(
  id SERIAL PRIMARY KEY,
  order_id BIGINT unsigned COMMENT 'id заказа внешний ключ',
  tank_shop_id BIGINT unsigned COMMENT 'id товара в магазине',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tank_shop_id) references tank_shop(id),
  FOREIGN KEY (order_id) references orders(id)
) COMMENT = 'Состав заказа';
    


DROP TABLE IF exists nation; -- нациия военной техники
CREATE TABLE nation (
	id SERIAL PRIMARY KEY, 
    nation_name VARCHAR(100) unique COMMENT 'Название нации',
    INDEX nation_idx(nation_name));
    
    
    
    
DROP TABLE IF exists military_equipment_division; -- подразделение военной техники
CREATE TABLE military_equipment_division(
	id SERIAL PRIMARY key,
    type_name VARCHAR(100));
    
    
    
DROP TABLE IF exists ttc; -- тактико техничесские характеристики техники
CREATE TABLE ttc(
	id SERIAL PRIMARY KEY, 
    armor_penetration BIGINT unsigned COMMENT 'бронепробитие',
    recharge BIGINT unsigned COMMENT 'перезарядка', 
    damage BIGINT unsigned COMMENT 'урон', 
    rate_fire BIGINT unsigned COMMENT 'скорострельность (кол-во выстрелов/мин)', 
    Damage_per_minute_total DECIMAL (4,2) AS (damage * rate_fire) STORED COMMENT 'урон в минуту',
    endurance BIGINT unsigned COMMENT 'прочночть',
    weight BIGINT unsigned COMMENT 'вес', 
    speed  BIGINT unsigned COMMENT 'скорость ', 
    premium bit default 0) COMMENT 'тактико техничесские характеристики техники';
    
    
        
    
DROP TABLE IF exists military_technics; -- военная техника
CREATE TABLE military_technics(
	id SERIAL PRIMARY KEY, 
    name VARCHAR(100),
    nation_id BIGINT UNSIGNED NOT null,
    military_equipment_division_id BIGINT unsigned not NULL, -- подразделение военной техники
    ttc_id BIGINT unsigned not null,                         -- тактико техничесские хар-ки
    type_military_equipment_id BIGINT unsigned not null,      -- вид военной техники
    INDEX name_idx(name)); 
   

   
DROP TABLE IF EXISTS accounts_technics;   -- промежуточная таблица аккаунты-техника
CREATE TABLE accounts_technics(
    accounts_id BIGINT UNSIGNED NOT null,
    technics_id BIGINT UNSIGNED NOT null unique,
    FOREIGN KEY (accounts_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (technics_id) REFERENCES military_technics(id) ON UPDATE CASCADE ON DELETE cascade);
   
   
  ALTER TABLE military_technics ADD CONSTRAINT fk_nation
    FOREIGN KEY (nation_id) REFERENCES nation(id);
   
   ALTER TABLE military_technics ADD CONSTRAINT fk_military_equipment_division
    FOREIGN KEY (military_equipment_division_id) REFERENCES military_equipment_division(id);
   
  ALTER TABLE military_technics ADD CONSTRAINT fk_ttc_id
    FOREIGN KEY (ttc_id) REFERENCES ttc(id); 
   
  ALTER TABLE tank_shop ADD CONSTRAINT fk_shop_technics
    FOREIGN KEY (technics_id) REFERENCES military_technics(id);
   
     
  ALTER TABLE tank_shop ADD CONSTRAINT fk_shop_ttc_id
    FOREIGN KEY (ttc_id) REFERENCES ttc(id);
    
   
    
   
 
    
    
   
    
