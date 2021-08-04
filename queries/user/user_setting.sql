

-- user preference
SELECT *
FROM
     "user-orga-settings" uas
WHERE 1=1
    AND uas."userId" = 220610
;


-- user preference
-- by user / identifier
SELECT *
FROM
     "user-orga-settings" uas
WHERE 1=1
    AND uas."userId" = 220610
;

-- user preference
-- delete
DELETE
FROM
     "user-orga-settings" uas
WHERE 1=1
    AND uas."userId" = 220610
;