
DROP DATABASE IF EXISTS flights_air;
CREATE DATABASE flights_air;
USE flights_air;


CREATE TABLE flights 
	(id serial primary key,
    `from` VARCHAR(255),
    `to` VARCHAR(255)
);
INSERT INTO flights (`from`, `to`) values
 ('Moscow', 'Vladivostok'), ('Kazan', 'Moscow'), ('Saint-Peterburg', 'Sochi');

CREATE TABLE cities (
  label VARCHAR(255),
  `name` VARCHAR(255)
);
    
INSERT INTO cities (label, `name`)
VALUES ('Moscow','Москва'), ('Kazan','Казань'), ('Saint-Peterburg','Санкт-Питербург'), ('Vladivostok', 'Владивосток'),('Sochi', 'Сочи');


-- показать название городов на русском из таблицы flights
select 
(select name from cities where label = flights.`from`)  as `from`,
(select name from cities where label = flights.`to`)  as `to`
from flights

select `from`.name as `from`, `to`.name as `to` 
from flights
join cities as `from` on flights.`from` = `from`.label
join cities as `to` on flights.`to`  = `to`.label
order by id;





























