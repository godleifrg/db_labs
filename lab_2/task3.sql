/*Выбрать объекты, пользование которых бесплатно для членов клуба.
*/
use cd;
SELECT * FROM facilities WHERE membercost = 0;