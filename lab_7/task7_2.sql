/*Создайте таблицу payments со структурой (payid INT PK, FK on booking.bookid; payment  DECIMAL.)*/
USE cd;
CREATE TABLE payments (
  payid INT PRIMARY KEY AUTO_INCREMENT,
  bookid INT,
  payment DECIMAL DEFAULT 0,
  FOREIGN KEY (bookid) REFERENCES bookings(bookid)
);

/*Добавьте в таблицу bookings поле payed, смысл которого оплачена или не оплачена аренда.*/

ALTER TABLE bookings ADD payed TINYINT DEFAULT 0;

/*событие на запрет удаления оплаченных бронирований*/

DELIMITER $$

DROP TRIGGER IF EXISTS prevent_payment_deletion $$
CREATE TRIGGER prevent_payment_deletion 
BEFORE DELETE ON bookings 
FOR EACH ROW 
BEGIN
  IF (OLD.payed = 1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Can not delete a paid booking!';
  END IF;
END$$

DELIMITER ;

/*2) После отметки оплаты, заносят в таблицу payments запись с соответствующим значением PK 
и суммой оплаты, для вычисления которой используется функция созданная в Task-7-1.*/
/*3) При отмене оплаты - удаляет соответствующую запись в таблице payments.*/
DELIMITER $$
/*В данном триггере происходит удаление и замена записи*/
DROP TRIGGER IF EXISTS payment_record $$
CREATE TRIGGER payment_record 
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    CASE
        WHEN NEW.payed = OLD.payed THEN BEGIN END;
        WHEN NEW.payed = 1 THEN
            INSERT INTO payments(bookid, payment)
            VALUES(NEW.bookid, CalculateRentalCost(NEW.memid, NEW.facid, NEW.slots));
        WHEN NEW.payed = 0 THEN
            DELETE FROM payments p WHERE p.bookid = NEW.bookid;
    END CASE;
END $$

/*Если бронь изменила свой статус оплаты, то удаляет\добавляет оплату (в ином случае делает ничего)*/

DROP TRIGGER IF EXISTS payed_in_book $$
CREATE TRIGGER payed_in_book 
AFTER INSERT ON bookings 
FOR EACH ROW
BEGIN
    IF NEW.payed = 1 THEN
        INSERT INTO payments(bookid, payment)
        VALUES(NEW.bookid, CalculateRentalCost(NEW.memid, NEW.facid, NEW.slots));
    END IF;
END $$

DELIMITER ;
/*изменение статуса записей*/

UPDATE bookings 
SET payed = 1
WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';

/*Посчитайте (написав соответствующий скрипт) оплату на июль 2012 года двумя способами: 1) используя данные таблицы payments*/

SELECT SUM(payment) as July1
FROM payments;

/*2) используя только функцию из Task-7-1 и данные таблицы bookings.*/

SELECT SUM(CalculateRentalCost(memid, facid, slots)) as July2
FROM bookings 
WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';
/*Вывод: при подсчете July1 и July2 выдали одинаковые значения*/