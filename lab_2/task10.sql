/*Выберите 10 фамилий членов клуба упорядочите их по алфавиту без повторов.*/
use cd;
SELECT DISTINCT surname
FROM members
ORDER BY surname
LIMIT 10;
