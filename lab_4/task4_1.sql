/*Добавить новый объект (‘spa’), стоимость создания (initialoutlay) = 100000, стоимость обслуживания 
(monthlymaintenance) = 800, стоимость аренды гостем = 30, членом клуба = 20.*/
USE cd;
INSERT INTO facilities (facid, facility, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (9, 'Spa', 20, 30, 100000, 800);
