USE cd;

DELIMITER $$

DROP FUNCTION IF EXISTS CalculateRentalChangeImproved $$
CREATE FUNCTION CalculateRentalChangeImproved(facility_id INT, fraction FLOAT, start_time TIMESTAMP, end_time TIMESTAMP)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE income DECIMAL(10, 2);
    DECLARE maintenance DECIMAL(10, 2);
    DECLARE net_income DECIMAL(10, 2);
    DECLARE cost DECIMAL(10, 2);
    DECLARE beta DECIMAL(10, 2);

    -- расчет общего дохода без учета затрат на обслуживание за заданный период
    SELECT SUM(p.payment) INTO income
    FROM payments AS p
    JOIN bookings AS b ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE facility_id = b.facid AND
    b.starttime BETWEEN start_time AND end_time
    GROUP BY b.facid;

    -- нсли нет дохода, возвращаем 0 для указания отсутствия изменений
    IF income IS NULL THEN RETURN 0;
    END IF;

    -- расчет общих затрат на обслуживание за заданный период
    SELECT f.monthlymaintenance * (MONTH(end_time) - MONTH(start_time) + 1) INTO maintenance
    FROM facilities AS f
    JOIN bookings AS b ON b.facid = f.facid
    WHERE facility_id = b.facid
    GROUP BY b.facid;

    -- расчет общей стоимости объекта
    SELECT f.initialoutlay INTO cost FROM facilities AS f
    WHERE facility_id = f.facid;

    -- расчет чистого дохода
    SET net_income = (income - maintenance);

    -- проверка на окупаемость
    IF net_income <= 0 OR cost <= net_income THEN RETURN 0;
    END IF;

    -- расчет коэффициента для корректировки стоимости аренды на основе анализа прибыльности за указанный период
    SET beta = ((1 / fraction) * (cost - net_income) / cost * (1 - maintenance / income) + maintenance / income);
    RETURN beta;
END $$

DELIMITER ;
