USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS calculate_profit $$
CREATE PROCEDURE calculate_profit(month_year DATE)
READS SQL DATA
BEGIN
    SELECT 
        b.facid AS FacilityID,
        f.facname AS FacilityName,
        IFNULL(
            f.initialoutlay / NULLIF(SUM(p.payment) - f.monthlymaintenance, 0),
            10000000000000
        ) AS Profitability
    FROM bookings AS b
    JOIN payments AS p ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE MONTH(b.starttime) = MONTH(month_year)
    AND YEAR(b.starttime) = YEAR(month_year)
    GROUP BY b.facid, f.facname;
END $$

CALL calculate_profit('2012-07-01');
