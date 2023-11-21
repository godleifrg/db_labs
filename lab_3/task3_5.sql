/*Выберите ФИО (== имя + фамилия) всех, кто покупал корты 1 и 2.*/
USE cd;
SELECT DISTINCT concat(firstname,' ', surname) as membername FROM members 
JOIN bookings ON bookings.memid = members.memid 
JOIN facilities ON facilities.facid = bookings.facid
WHERE facility LIKE '%Court 1%' OR facility LIKE '%Court 2%';