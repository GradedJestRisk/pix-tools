SELECT
     'target profile =>'
    ,tp.id
    ,tp.name
    ,tp."isPublic"
    ,tp.outdated
--     tp.*
FROM "target-profiles" tp
WHERE 1=1
     AND tp.name LIKE '%–%'
;