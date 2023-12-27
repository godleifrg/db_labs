/*Рассчитайте для каждого члена количество рекомендаций, данных этим 
членом клуба, искючив членов, которые не давали рекомендаций.*/
USE cd;
SELECT CONCAT(mem.firstname, ' ', mem.surname) AS 'ФИО', COUNT(mem.memid) AS 'Кол-во рекомендаций'
FROM members AS mem
JOIN members AS mem1 ON mem1.recommendedby = mem.memid
GROUP BY mem.memid;