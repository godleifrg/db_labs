USE cd;
DELIMITER //
CREATE PROCEDURE CalculateMostProfitableFacilityPerMonth()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_month INT;
 
    DECLARE cur CURSOR FOR
    SELECT DISTINCT MONTH(starttime) AS month FROM bookings ORDER BY month;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO current_month;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @sql_query = CONCAT('
            SELECT 
                MONTHNAME(starttime) AS month_name,
                facility,
                SUM(CASE WHEN memid != 0 THEN membercost * slots ELSE guestcost * slots END) AS total_profit
            FROM bookings b
            JOIN facilities f ON b.facid = f.facid
            WHERE MONTH(starttime) = ', current_month, '
            GROUP BY facility
            ORDER BY total_profit DESC
            LIMIT 12;
        ');

        PREPARE stmt FROM @sql_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    CLOSE cur;
END//
DELIMITER ;