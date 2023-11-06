/*Выбрать имена объектов с их качественной стоимостью (качественной стоимостью == ‘дешевый’ если monthlymaintenance < 100 и ‘дорогой’ в противном случае*/
USE cd;
SELECT facility, CASE WHEN monthlymaintenance < 100 THEN 'дешевый' ELSE 'дорогой' 
END AS Качеств_стоим FROM facilities;