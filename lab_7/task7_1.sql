/*Создайте функцию, которая рассчитывает стоимость каждой аренды (для каждой записи таблицы bookings)*/
USE cd;
DELIMITER $$
DROP FUNCTION IF EXISTS rentalcost $$
CREATE FUNCTION rentalcost(memid INT, facid INT, slots INT)
RETURNS DECIMAL(10, 2)
NOT DETERMINISTIC
BEGIN
	DECLARE cost DECIMAL(10, 2);
	SET cost = (SELECT IF(memid = 0, guestcost, membercost) * slots
	FROM facilities f
	WHERE facid = f.facid);
	RETURN cost;
END$$
DELIMITER ;
SELECT rentalcost(memid, facid, slots) 
FROM bookings;