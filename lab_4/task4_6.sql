/*Увеличьте стоимость аренды  корта 1 (facid = 0) на 10% для членов и гостей.*/
USE cd;
UPDATE facilities set membercost = (membercost * 1.1), guestcost = (guestcost * 1.1) where facid = 0;