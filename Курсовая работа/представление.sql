


-- ПРЕДСТАВЛЕНИЕ ТАБ. ACCOUNTS С ЗАПРОСОМ ВОЗРАСТА АККАУНТОВ
CREATE OR REPLACE VIEW nick_email (id, nickname, email, age_acc) 
AS select id, nickname, email, TIMESTAMPDIFF(YEAR, created_at, NOW()) FROM accounts;

select * from nick_email;

-- drop view nick_email;