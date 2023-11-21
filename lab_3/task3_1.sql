/*Выберите лист времен  (timestamp) покупки/ использования объектов членом клуба 'David Farrell'.
*/
USE cd;
SELECT starttime FROM bookings
JOIN members ON members.memid = bookings.memid 
WHERE members.firstname LIKE 'David' AND members.surname LIKE 'Farrell';

