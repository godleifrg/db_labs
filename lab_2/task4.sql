/* Выбрать объекты, пользование которых платно для членов клуба
*/
use cd;
select * from facilities where membercost !=0;