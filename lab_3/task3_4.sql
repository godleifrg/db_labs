/*Выберите всех членов клуба и членов, которые их рекомендовали,  отсортировав их по имени и фамилии.*/
USE cd;
SELECT CONCAT(mem1.surname, ' ', mem1.firstname) AS 'Участник',
CONCAT(mem2.surname, ' ', mem2.firstname) AS 'Рекомендован'
FROM members as mem1
LEFT JOIN members AS mem2 ON mem1.recommendedby = mem2.memid
ORDER BY Участник;