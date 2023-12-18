/*Создайте функцию, которая рассчитывает стоимость каждой аренды (для каждой записи таблицы bookings)*/
USE cd;
DELIMITER $$
DROP FUNCTION IF EXISTS CalculateRentalCost $$
CREATE FUNCTION CalculateRentalCost(memid INT, facid INT, slots INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
	DECLARE cost DECIMAL(10, 2);
	SET cost = (SELECT IF(memid = 0, guestcost * slots, membercost * slots)
	FROM facilities f WHERE facid = f.facid);
	RETURN cost;
END$$
DELIMITER ;
SELECT CalculateRentalCost(memid, facid, slots) AS cost
FROM bookings;