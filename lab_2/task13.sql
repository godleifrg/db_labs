use cd;
SELECT firstname, surname, joindate
FROM members
WHERE joindate = (SELECT MAX(joindate) FROM members);