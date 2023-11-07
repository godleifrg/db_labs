/*Выбрать объекты, пользование которых бесплатно для членов клуба.
*/
use cd;
SELECT facility FROM facilities WHERE membercost = 0;