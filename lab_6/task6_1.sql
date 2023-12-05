/*Выберите начальное и конечное время последних 10 аренд  объектов, 
упорядочив их по времени их окончания.*/
USE cd;
SELECT starttime AS 'start_time', ADDTIME(starttime, SEC_TO_TIME(slots * 1800)) AS end_time
FROM bookings
ORDER BY end_time DESC
LIMIT 10;