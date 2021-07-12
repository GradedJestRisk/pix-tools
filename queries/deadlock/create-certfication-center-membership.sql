-- Missing role
SELECT
    'organization=>',
    o.id,
    o.name,
    o."externalId",
    'user=>',
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u.username,
   'membership =>',
--    m.id,
    m."organizationRole",
   'memberships =>',
    m.*
FROM
    memberships m
        INNER JOIN users         u ON m."userId" = u.id
        INNER JOIN organizations o ON m."organizationId" = o.id
WHERE 1=1
  --  AND u.email = 'sco.admin@example.net'
  --  AND u.id = 220610
  --  AND u.username IS NOT NULL
  --  AND m.id = 1
      AND m."organizationRole" = 'ADMIN'
  --  AND o.id = 7930
--      AND o.name = 'Collège The Night Watch'
      AND o."externalId" = '1237457A'
  --  AND o."isManagingStudents" = FALSE
ORDER BY
    m.id ASC
;

SELECT
    "externalId",
    o.id,
    COUNT(1)
FROM organizations o
GROUP BY o."externalId", o.id
HAVING COUNT(1) > 1
;


-- Certification center + membership
SELECT
    'certification center=>'
    ,cc.id
    ,cc.name
    ,cc."externalId"
    --,cc.type
    ,'membership=>'
    ,ccm.id
    ,ccm."createdAt"
    ,'user=>'
    ,u.id
    ,u.email
    ,u."firstName"
    ,u."lastName"
FROM "certification-centers" cc
    INNER JOIN "certification-center-memberships" ccm ON ccm."certificationCenterId" = cc.id
    INNER JOIN users u ON u.id = ccm."userId"
WHERE 1=1
 -- AND u.email IS NULL
--  AND cc.id   = 3
  AND cc.name         = 'Centre SCO des Anne-Étoiles'
  AND cc."externalId" = '1237457A'
--    AND cc.type = 'SCO'
;



-- CC memberships to create
SELECT
    m."userId"
FROM
    organizations o
        INNER JOIN memberships m ON m."organizationId" = o.id
WHERE 1=1
      AND o."externalId"       = '1237457A'
      AND m."organizationRole" = 'ADMIN'
      AND m."disabledAt"       IS NULL
      AND NOT EXISTS (
          SELECT 1
          FROM "certification-centers" cc
              INNER JOIN "certification-center-memberships" ccm ON ccm."certificationCenterId" = cc.id
          WHERE 1=1
            AND cc."externalId" = o."externalId"
            AND ccm."userId"    = m."userId"
      )
;

-- Users without membership
SELECT
       u.id,
       u.email
FROM
     users u
WHERE 1=1
--    AND u.email IS NOT NULL
    AND u."firstName" = ''
    AND u."lastName" = ''
    AND NOT EXISTS (
        SELECT 1
        FROM "certification-centers" cc
            INNER JOIN "certification-center-memberships" ccm ON ccm."certificationCenterId" = cc.id

        WHERE 1=1
         -- AND u.email IS NULL
        --  AND cc.id   = 3
          AND cc.name         = 'Centre SCO des Anne-Étoiles'
          AND cc."externalId" = '1237457A'
          AND ccm."userId" = u.id
        --    AND cc.type = 'SCO'
        )
ORDER BY u.email
;
