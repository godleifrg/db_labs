/*Выберите имя, фамилию и дату вступления в клуб последних из всех вступивших.*/
use cd;
SELECT firstname, surname, joindate
FROM members
WHERE joindate = (SELECT MAX(joindate) FROM members);