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

LOCK TABLES `accounts` WRITE;
INSERT INTO `accounts` VALUES 
(1,'ut','goyette.vladimir@example.net','2af5cfe78c0bf8ab8e01ff9a7ec31f44016bbd2c',9490486786,'2018-09-05 04:12:52','\0'),
(2,'aut','norberto.marks@example.org','83f68b3fc13d80d550685b0fc7c6d54d95c038f1',9447234520,'2013-08-01 19:42:13',''),
(3,'non','wdaugherty@example.com','00e8ca91b9041f33d17204c26fcce9b7aac73d30',9523629677,'2020-12-19 18:28:07','\0'),
(4,'omnis','grempel@example.net','c0755e779a9dc3a732454b485e8f6f73bd898c8f',9609090950,'1974-09-29 10:02:36',''),
(5,'incidunt','nitzsche.eloisa@example.org','ec2d6876c1f2e525c21e13f4d4a01a7655b3753f',9380274698,'1996-02-15 15:57:32','\0'),
(6,'deserunt','heber.hackett@example.net','467ef0ca15e3e57a6be1af0b8a88737593a3f7e7',9240410608,'1989-05-02 06:36:24',''),
(7,'iure','kiley.towne@example.org','762d34951084f5050b6ecf8c57de2509996da0d6',9439722341,'1972-09-22 12:39:02','\0'),
(8,'labore','oroberts@example.com','90d881640e82c46810fb3e11b455c087979aa24b',9863248280,'1972-03-06 05:43:16','\0'),
(9,'magni','robin.dare@example.com','65f52641668e70965c9e2d4258d81ddaddf7cb18',9231646413,'1975-06-28 01:12:23','\0'),
(10,'rerum','ishanahan@example.com','f39ad3e0aa6e61857da1f0ae226789608ecfc87a',9526797123,'2016-02-14 00:23:36','');
UNLOCK TABLES;

DROP TABLE IF EXISTS tank_shop;
CREATE TABLE tank_shop(
    id SERIAL PRIMARY KEY,
    technics_id BIGINT unsigned COMMENT 'id танка',
    ttc_id BIGINT unsigned COMMENT 'внешний ключ тактико технических характеристик',
    price BIGINT(11) COMMENT 'Цена');
   
LOCK TABLES `tank_shop` WRITE;
INSERT INTO `tank_shop`(technics_id, ttc_id, price) VALUES 
(4, 2, 2300);
UNLOCK TABLES; 
      

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  account_id BIGINT unsigned COMMENT 'аккаунт', 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания заказа',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Текущая дата',
  FOREIGN KEY (account_id) REFERENCES accounts(id)
) COMMENT = 'Заказы';

LOCK TABLES `orders` WRITE;
INSERT INTO `orders`(account_id) VALUES 
(1),
(2),
(4),
(3);
UNLOCK TABLES;

DROP TABLE IF EXISTS orders_tank_shop;
CREATE TABLE orders_tank_shop(
  id SERIAL PRIMARY KEY,
  order_id BIGINT unsigned COMMENT 'id заказа внешний ключ',
  tank_shop_id BIGINT unsigned COMMENT 'id товара в магазине',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания заказа',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Текущая дата',
  FOREIGN KEY (tank_shop_id) references tank_shop(id),
  FOREIGN KEY (order_id) references orders(id)
) COMMENT = 'Состав заказа';
    
LOCK TABLES `orders_tank_shop` WRITE;
INSERT INTO `orders_tank_shop`(order_id, tank_shop_id) VALUES 
(1, 1),
(2, 1),
(4, 1),
(3, 1);
UNLOCK TABLES;


DROP TABLE IF exists nation; -- нациия военной техники
CREATE TABLE nation (
	id SERIAL PRIMARY KEY, 
    nation_name VARCHAR(100) unique COMMENT 'Название нации',
    INDEX nation_idx(nation_name));
    
LOCK TABLES `nation` WRITE;
INSERT INTO `nation` VALUES 
(10,' Германия'),
(9,' Италия'),
(5,' Китай'),
(11,' Польша'),
(1,' СССР'),
(8,' США'),
(4,' Франция'),
(6,' Чехословакия'),
(7,' Швеция'),
(3,' Япония'),
(2,'Англия');
UNLOCK TABLES;  

DROP TABLE IF exists level_military_equipment; -- уровень силы техники
CREATE TABLE level_military_equipment(
	id SERIAL PRIMARY KEY, 
    `level` VARCHAR(4) COMMENT 'уровень силы');
   
LOCK TABLES `level_military_equipment` WRITE;
INSERT INTO `level_military_equipment`(`level`) values
('I'),
('II'),
('III'),
('IV'),
('V'),
('VI'),
('VII'),
('VIII'),
('IX'),
('X');
UNLOCK TABLES;  
    
    
DROP TABLE IF exists military_equipment_division; -- подразделение военной техники
CREATE TABLE military_equipment_division(
	id SERIAL PRIMARY key,
    type_name VARCHAR(100) unique);
   
LOCK TABLES `military_equipment_division` WRITE;
INSERT INTO `military_equipment_division` VALUES 
(1,'ОБТ'),
(2,' лёгкий танк'),
(3,' средний танк'),
(4,' ПТ-САУ'),
(5,' тяжёлый танк'),
(6,' САУ');
UNLOCK TABLES;    
    
    
DROP TABLE IF exists ttc; -- тактико техничесские характеристики техники
CREATE TABLE ttc(
	id SERIAL PRIMARY KEY, 
    armor_penetration INT(10) unsigned COMMENT 'бронепробитие', 
    damage BIGINT(10) unsigned COMMENT 'урон', 
    rate_fire decimal(10,4) unsigned COMMENT 'скорострельность (кол-во выстрелов/мин)',
    endurance BIGINT(10) unsigned COMMENT 'прочночть',
    weight decimal(10,4) COMMENT 'вес(тонн)', 
    speed BIGINT(10) COMMENT 'скорость(км/ч) ',
    Damage_per_minute decimal(10,4) AS (damage * rate_fire) STORED COMMENT 'урон в минуту') 
    COMMENT 'тактико техничесские характеристики техники';
 
   
LOCK TABLES `ttc` WRITE;
INSERT INTO `ttc`(armor_penetration, damage, rate_fire, endurance, weight, speed) values
(330, 320, 9.09, 1950, 39.80, 50),
(247, 250, 8, 1300, 35.30, 51),
(490, 303, 4.38, 2400, 70.95, 59),
(247, 250, 8, 1300, 35.30, 55);
UNLOCK TABLES;   
        
    
DROP TABLE IF exists military_technics; -- военная техника
CREATE TABLE military_technics(
	id SERIAL PRIMARY KEY, 
    name VARCHAR(100),
    nation_id BIGINT UNSIGNED NOT null,
    military_equipment_division_id BIGINT unsigned not NULL, -- подразделение военной техники
    ttc_id BIGINT unsigned NOT null,
    level_id BIGINT unsigned NOT null,
    is_premium bit default 0 COMMENT 'Является ли примиумной. 1 да 0 нет. Премиум техника продаётся в магазине за реальную валюту',
    INDEX name_idx(name),
    foreign KEY (level_id) REFERENCES level_military_equipment(id)); 
   
LOCK TABLES `military_technics` WRITE;
INSERT INTO `military_technics`(name, nation_id, military_equipment_division_id, ttc_id, level_id, is_premium)values
('T-62', 1, 3, 1, 10, 0),
('T-44', 1, 3, 2, 8, 0),
('ИС-7', 1, 5, 3, 10, 0),
('Т-44-Premium', 1, 3, 2, 8, 1);
UNLOCK TABLES;

DROP TABLE IF EXISTS accounts_technics;   -- промежуточная таблица аккаунты-техника
CREATE TABLE accounts_technics(
    accounts_id BIGINT UNSIGNED NOT null,
    technics_id BIGINT UNSIGNED NOT null,
    FOREIGN KEY (accounts_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (technics_id) REFERENCES military_technics(id) ON UPDATE CASCADE ON DELETE cascade);
   
LOCK TABLES `accounts_technics` WRITE;
INSERT INTO `accounts_technics`values
(1,3),
(1,1),
(1,2),
(1,4),
(2,4),
(2,3),
(2,1),
(2,2),
(3,3),
(4,1);
UNLOCK TABLES;   
 
   
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
   
  -- ALTER TABLE military_technics ADD CONSTRAINT fk_level_id 
   --  foreign KEY (level_id) REFERENCES level_military_equipment(id)
    
   
    
   
 
    
    
   
    
