/*Выберите членов клуба, которые рекомендовали других членов для вступления*/
USE cd;
SELECT
mem1.surname,
mem2.firstname
FROM members AS mem1
JOIN members as mem2
WHERE mem1.recommendedby = mem2.memid