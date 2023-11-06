/*Выбрать всех членов клуба, зарегистрированных с сентября 2012 года.*/
use cd;
SELECT *
FROM members
WHERE joindate >= '2012-09-01';