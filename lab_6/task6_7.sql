/*Подсчитайте количество участников, чья фамилия начинается на определенную букву, отсортировав по буквам в порядке убывания.*/
USE cd;
SELECT LEFT(surname,1) AS letter_surname, COUNT(*) AS count_members
FROM members
GROUP BY letter_surname
ORDER BY letter_surname DESC;