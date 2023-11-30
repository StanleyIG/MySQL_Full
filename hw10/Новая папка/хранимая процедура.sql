-- РЕАЛИЗАЦИЯ ДОБАВЛЕНИЯ АККАУНТА И ТЕХНИКИ В ТАБЛИЦУ ПУТЁМ ТРАНЗАКЦИИ В ХРАНИМОЙ ПРОЦЕДУРЕ
-- ЕСЛИ СРАБАТЫВАЕТ ОШИБКА(ДУПЛИКАТ КЛЮЧЕЙ), ТО ТРАНЗАКЦИЯ ОТКАТЫВАЕТСЯ "ROLLBACK", ЕСЛИ
-- ОШИБОК НЕТ, ТО РЕАЛИЗУЕТСЯ "COMMIT" И ЗАПИСЫВАЕТСЯ В ЖУРНАЛ ТРАЗАКЦИЙ.



DROP PROCEDURE IF EXISTS wartunder.sp_not_repeat;

DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `wartunder`.`sp_not_repeat`(
accounts_id BIGINT, technics_id BIGINT,
out tran_result varchar(100))
BEGIN
	
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 


	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = concat('УПС. Ошибка: ', code, ' Текст ошибки: ', error_string);
	END;

	START TRANSACTION;
	 INSERT INTO accounts_technics (accounts_id, technics_id)
	 VALUES (accounts_id, technics_id);
	
	IF `_rollback` THEN
		-- SET tran_result = 'ROLLBACK';
		ROLLBACK;
	ELSE
		SET tran_result = 'O K';
		COMMIT;
	END IF;
END$$
DELIMITER ;





