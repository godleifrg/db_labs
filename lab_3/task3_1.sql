/*Выберите лист времен  (timestamp) покупки/ использования объектов членом клуба 'David Farrell'.
*/
USE cd;
SELECT starttime FROM bookings
JOIN members ON members.memid = bookings.memid 
WHERE members.firstname = 'David' AND members.surname = 'Farrell';

