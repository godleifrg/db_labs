/*Выбрать объекты, которые платны для членов клуба, но стоимость использование не превышает 1/50 от стоимость месячного обслуживания (monthlymaintenance).*/
use cd;
select * from facilities where membercost > 0 
and membercost <= monthlymaintenance/50