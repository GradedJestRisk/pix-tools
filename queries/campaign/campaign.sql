
-- campaign
-- given a code
SELECT
    c."organizationId",
    c.id,
    c.code,
    c.name,
    'http://localhost:4200/campagnes/' || c.code
    --c.*
--    c."createdAt"
FROM
    campaigns c
WHERE 1=1
--  AND c.id =
--    AND c."archivedAt" IS NULL
ORDER BY
    c."organizationId",
    c.code
;


-- campaign
-- given a organization
SELECT
    c."organizationId",
    c.id,
    c.code,
    c.name,
    c.*
--    c."createdAt"
FROM
    campaigns c
WHERE 1=1
--  AND c.id =
    AND c.code = 'ZVDMJC924'
--    AND c."archivedAt" IS NULL
ORDER BY
    c."organizationId",
    c.code
;



-- campaign
-- given a organization
SELECT
    c."organizationId",
    c.id,
    c.code,
    c.name,
    c.*
--    c."createdAt"
FROM
    campaigns c
WHERE 1=1
--  AND c.id =
    AND c."organizationId" = 3
--    AND c."archivedAt" IS NULL
ORDER BY
    c."organizationId",
    c.code
;


-- campaign + organization
-- given a code
SELECT
   'organization=>',
    o.id organization_dtf,
    o.name,
    o.type,
    'campaign=>',
    c.id campaign_dtf,
    c.code,
    c.name,
    'http://localhost:4200/campagnes/' || c.code,
    '-'
    --,o.*
--    c."createdAt"
FROM
    campaigns c
        INNER JOIN organizations o on c."organizationId" = o.id
WHERE 1=1
--  AND c.id = 6
   --AND c.code = 'ZVDMJC924'
--    AND c."archivedAt" IS NULL
 --   AND c."organizationId" = 3
    -- AND o.id   <>  3
     AND o.type = 'SCO'
     --AND o.name = 'Collège The Night Watch'
    AND o."isManagingStudents" = true
    --AND c.type = 'ASSESSMENT'
ORDER BY
    c."organizationId",
    c.code
;




-- campaign + organization + tag
-- given a code
SELECT
   'organization=>',
    o.id organization_dtf,
    o.name,
    o.type,
   'tags => ',
    t.name,
    'campaign=>',
    c.id campaign_dtf,
    c.code,
    c.name,
    'http://localhost:4200/campagnes/' || c.code,
    'http://localhost.fr:8080/campagnes/' || c.code,
    '-'
    --,o.*
--    c."createdAt"
FROM
    campaigns c
        INNER JOIN organizations o on c."organizationId" = o.id
            INNER JOIN "organization-tags" ot ON ot."organizationId" = o.id
                     INNER JOIN tags t ON t.id = ot."tagId"
WHERE 1=1
    --  AND c.id = 6
-- AND o.id   <>  3
    -- AND o.type = 'SCO'
     --AND o.name = 'Collège The Night Watch'
    AND t.name = 'POLE EMPLOI'
ORDER BY
    c."organizationId",
    c.code
;



-- create campaign

INSERT INTO campaigns
    ( code, name, "organizationId", "creatorId", "targetProfileId")
VALUES
   ('RESTRICTD', 'Doublon', 6, 100066, 1)
  ;


select
   'target-profile=>',
    tf.id,
    tf."isSimplifiedAccess",
       tf.*
FROM
     "target-profiles" tf
WHERE 1=1
    --AND tf."isSimplifiedAccess" IS TRUE
;

-- campaign + organization
-- given a code
SELECT
   'target-profile=>',
    tf.id,
    tf."isSimplifiedAccess",
    'campaign=>',
    c.id campaign_dtf,
    c.code,
    c.name,
    'http://localhost:4200/campagnes/' || c.code,
    '-'
    --,o.*
--    c."createdAt"
FROM
     "target-profiles" tf
        INNER JOIN campaigns c on c."targetProfileId" = tf.id
WHERE 1=1
    --AND tf."isSimplifiedAccess" IS TRUE
--  AND c.id = 6
   --AND c.code = 'ZVDMJC924'
--    AND c."archivedAt" IS NULL
 --   AND c."organizationId" = 3
    -- AND o.id   <>  3
    --AND c.type = 'ASSESSMENT'
ORDER BY
    c."organizationId",
    c.code
;

