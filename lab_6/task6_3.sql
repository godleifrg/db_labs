/*Выберите процент использования объектов по месяцам, упорядочив по возрастанию*/
USE cd;

WITH dop AS 
(SELECT facility, sum(slots) as slots_sum, date_format(book.starttime, '%M %Y') as month_year FROM facilities fac
JOIN bookings book ON fac.facid = book.facid
GROUP BY fac.facid, month_year) 

SELECT d1.facility, round(d1.slots_sum / SUM(d2.slots_sum) *100, 3) AS 'Using object, %', d1.month_year 
FROM dop d1
JOIN dop d2 ON d1.month_year = d2.month_year 
GROUP BY d1.facility, d1.slots_sum, d1.month_year  
ORDER BY 2;