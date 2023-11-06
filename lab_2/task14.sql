/*Выберите самый дорогой и самый дешевый объект.*/
use cd;
SELECT facility, 'Самый дорогой' AS 'Качественная стоимость' FROM facilities
WHERE initialoutlay = (SELECT MAX(initialoutlay)  FROM facilities)
UNION 
SELECT facility, 'Самый дешёвый' FROM facilities
WHERE initialoutlay = (SELECT MIN(initialoutlay) FROM facilities);