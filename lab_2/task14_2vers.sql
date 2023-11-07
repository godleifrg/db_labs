use cd;
SELECT facility, initialoutlay
FROM facilities
WHERE initialoutlay = (SELECT MAX(initialoutlay) FROM facilities)
   or initialoutlay = (SELECT MIN(initialoutlay) FROM facilities);