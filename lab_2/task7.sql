/*Выбрать объекты с ID равным 1 и 5.*/
use cd;
select * 
from facilities 
where facid in (1,5);