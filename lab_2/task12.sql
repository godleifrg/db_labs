/*Найдите дату последней регистрации члена клуба.*/
use cd;
SELECT MAX(joindate) AS last_registration_date
FROM members;