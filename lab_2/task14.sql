use cd;
SELECT *
FROM facilities
WHERE membercost = (SELECT MAX(membercost) FROM facilities)
   OR membercost = (SELECT MIN(membercost) FROM facilities);