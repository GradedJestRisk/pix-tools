SELECT id, name, status
FROM skills
;

SELECT
    id, name, status from skills
WHERE 1=1
    AND name  LIKE '%empreinteEco6%'
LIMIT 3;