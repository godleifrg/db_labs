/*Выберите членов клуба, которые рекомендовали других членов для вступления*/
USE cd;
SELECT CONCAT (firstname,' ', surname) AS membername FROM members
WHERE memid IN (SELECT recommendedby FROM members) ; 