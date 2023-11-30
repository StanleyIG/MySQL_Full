-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF exists hello;
DELIMITER //
CREATE FUNCTION hello()
returns tinytext not deterministic
begin
	declare hours int;
	set hours = hour(now());
	case 
		when hours between 0 and 5 then 
		return 'Доброй ночи';
	    when hours between 6 and 11 then 
		return 'Доброй утро';
	    when hours between 11 and 18 then 
		return 'Доброй день';
	end case;
end//

select hello();

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
--  Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //
CREATE trigger not_null before insert  ON products
FOR EACH row 
BEGIN
if new.name is null or new.description is null or (new.name is null and new.description is null)
then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Не может быт NULL';
end if;
END//
DELIMITER ;


insert into products(name, description, price, catalog_id) 
values
(null,'core i25 25900K, 15GHz', 70750, 1);

insert into products(name, description, price, catalog_id) 
values
(null, Null, 70750, 1);


insert into products(name, description, price, catalog_id) 
values
('core i25', NULL, 70750, 1);








-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.
use shop;

DROP FUNCTION IF exists FIBONACCI;
DELIMITER //
CREATE FUNCTION FIBONACCI(num INT)
returns INT deterministic
begin
	declare fs double;
	set fs = SQRT(5);
	return (pow((1+fs) / 2.0, num) + pow((1-fs) / 2.0, num)) / fs;
end//

select FIBONACCI(10);
select FIBONACCI(11);















