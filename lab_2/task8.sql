USE cd;
SELECT facility, CASE WHEN monthlymaintenance < 100 THEN 'дешевый' ELSE 'дорогой' 
END AS Качеств_стоим FROM facilities;