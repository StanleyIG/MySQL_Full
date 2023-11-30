-- ТРИГГЕР ВЫДАЁТ ОШИБКУ ЕСЛИ ПОЛЛЬЗОВАТЕЛЬ ДОБАВЛЯЕТ(ПОКУПАЕТ) ТЕХНИКУ КОТОРАЯ У НЕГО УЖЕ ЕСТЬ. 
-- СОГЛАСНО ЗАДУМКЕ У КАЖДОГО ПОЛЬЗОВАТЕЛЯ МОЖЕТ БЫТЬ ТОЛЬКО ПО ОДНОЙ УНИКАЛЬНОЙ ТЕХНИКЕ ИЗ КАЖДОЙ НАЦИИ И УРОВНЯ.

use wartunder;

DELIMITER //
CREATE TRIGGER not_duplicate
before insert on accounts_technics
FOR each ROW
  begin  
     declare i int;
     set i = (select count(*) from accounts_technics where accounts_id = NEW.accounts_id
     and technics_id = new.technics_id); 
     if i > 0 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'у данного пользователя уже есть эта техника';
  end if;
end//
DELIMITER ;

-- ПРОВЕРКА ТРИГГЕРА
unlock TABLES;
INSERT INTO `accounts_technics` values
(7,1);
INSERT INTO `accounts_technics` values
(9,2);
INSERT INTO `accounts_technics` values
(9,3);
INSERT INTO `accounts_technics` values
(9,4);
INSERT INTO `accounts_technics` values
(9,4);
INSERT INTO `accounts_technics` values
(4,2);
INSERT INTO `accounts_technics` values
(2,4);
INSERT INTO `accounts_technics` values
(3,4);


-- ТАКОЙ ЖЕ ТРИГГЕР И НА ТАБЛИЦУ ЗАКАЗОВ И ПРОДУКТА
DELIMITER // 
CREATE TRIGGER not_duplicate_tank_shop
before insert on orders_tank_shop
FOR each ROW
  begin  
     declare i int;
     set i = (select count(*) from orders_tank_shop where order_id = NEW.order_id
     and tank_shop_id = new.tank_shop_id); 
     if i > 0 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'у данного пользователя уже есть эта техника';
  end if;
end//
DELIMITER ;
