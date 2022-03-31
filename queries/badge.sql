SELECT *
FROM "badge-acquisitions"
;


SELECT
    u.email,
    b.key
FROM "badge-acquisitions" ub
    INNER JOIN users u ON u.id = ub."userId"
    INNER JOIN badges b on b.id = ub."badgeId"
WHERE 1=1
    AND b.key LIKE '%EDU%'
;