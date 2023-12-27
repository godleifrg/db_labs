USE cd;
SELECT 
    EXTRACT(YEAR_MONTH FROM b.starttime) AS year_month,
    f.facility,
    SUM(CASE WHEN b.memid != 0 THEN f.membercost * b.slots ELSE f.guestcost * b.slots END) AS profit
FROM bookings b
JOIN facilities f ON b.facid = f.facid
GROUP BY year_month, facility
HAVING profit = (SELECT MAX(total_profit)
            FROM
            (SELECT 
            EXTRACT(YEAR_MONTH FROM b2.starttime) AS year_month,
            f2.facility,
            SUM(CASE WHEN b2.memid != 0 THEN f2.membercost * b2.slots ELSE f2.guestcost * b2.slots END) AS total_profit
            FROM bookings b2
            JOIN facilities f2 ON b2.facid = f2.facid
            GROUP BY year_month, facility) AS profit za mesyac
        WHERE year_month = EXTRACT(YEAR_MONTH FROM b.starttime)
    );