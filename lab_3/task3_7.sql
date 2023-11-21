/*Выберите список всех членов, включая человека, 
который их рекомендовал (если таковой имеется), 
без использования каких-либо объединений. 
Исключите в списке дубликаты, упорядочите лист по ФИО (==   имя + фамилия).*/
USE cd;
SELECT DISTINCT CONCAT(mem.surname,' ',mem.firstname) as membername,
CONCAT(rec.surname,' ',rec.firstname) as recname
FROM members mem, (SELECT memid, recommendedby, surname, firstname FROM members) rec  
WHERE mem.recommendedby=rec.memid;