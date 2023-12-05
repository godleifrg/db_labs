/*Выведите членов клуба, которые не арендовали объекты клуба; Удалите всех членов клуба, которые не арендовали объекты клуба;
Проверьте есть ли в клубе член с memid = 37*/
USE cd;
SELECT memid, surname, firstname FROM members WHERE memid NOT IN (SELECT DISTINCT memid FROM bookings);
SET SQL_SAFE_UPDATES = 0;
DELETE FROM members WHERE memid NOT IN (SELECT DISTINCT memid FROM bookings);
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM members;  
/*члена с memid = 37 в клубе нет*/