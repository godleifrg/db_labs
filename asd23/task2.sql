USE cd;
SELECT
    m.memid,
    SUM(
        COALESCE(amount.member_contrib, 0) * 1 +
        COALESCE(amount.recommended_contrib, 0) * 0.5 +
        COALESCE(amount.recommended_recommended_contrib, 0) * 0.1
    ) AS total_profits
FROM members m
LEFT JOIN(SELECT COALESCE(b.memid, m.recommendedby) AS memid,
        SUM(COALESCE(f.membercost * b.slots, f.guestcost * b.slots)) AS member_contrib
        FROM bookings b
        INNER JOIN facilities f ON b.facid = f.facid
        WHERE b.memid != 0
        GROUP BY memid
        ) AS amount ON amount.memid = m.memid
LEFT JOIN(SELECT COALESCE(b.memid, m.recommendedby) AS recommendedby,
            SUM(COALESCE(f.membercost * b.slots, f.guestcost * b.slots)) AS recommended_contrib
        FROM bookings b
        INNER JOIN facilities f ON b.facid = f.facid
        INNER JOIN members m ON b.memid = m.memid
        WHERE b.memid != 0
        GROUP BY recommendedby
    ) AS reco ON reco.recommendedby = m.memid
LEFT JOIN (SELECT COALESCE(b.memid, m2.recommendedby) AS recommended_recommendedby, 
            SUM(COALESCE(f.membercost * b.slots, f.guestcost * b.slots)) AS recommended_recommended_contrib
        FROM bookings b
        INNER JOIN facilities f ON b.facid = f.facid
        INNER JOIN members m1 ON b.memid = m1.memid
        INNER JOIN members m2 ON m1.recommendedby = m2.memid
        WHERE b.memid != 0
        GROUP BY recommended_recommendedby
    ) AS reco_reco ON reco_reco.recommended_recommendedby = m.memid
WHERE m.memid != 0
GROUP BY m.memid;
