USE cd;
SELECT firstname AS 'Имя или Объект' FROM members WHERE firstname != 'Guest'
UNION SELECT facility FROM facilities;