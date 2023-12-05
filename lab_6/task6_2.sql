/*Выберите количество аренд объектов клуба в каждый месяц.*/
USE cd;
SELECT YEAR(starttime) AS Год, MONTH(starttime) AS Месяц, facility AS 'object_name', COUNT(*) AS 'count_rents'
FROM bookings AS book
JOIN facilities AS fac ON book.facid = fac.facid
GROUP BY YEAR(starttime), MONTH(starttime), facility;