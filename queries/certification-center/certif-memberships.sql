-- User that may become members
SELECT
     'user=>'
--    ,u.id
    ,u.email
    ,u."firstName"
    ,u."lastName"
FROM
     users u
WHERE 1=1
     AND u.email IS NOT NULL
    AND NOT EXISTS (
      SELECT 1
        FROM "certification-centers" cc
        INNER JOIN "certification-center-memberships" ccm ON ccm."certificationCenterId" = cc.id
      WHERE 1=1
        --  AND cc.id   = 3
          AND cc.name = 'Centre SCO des Anne-Étoiles'
          AND cc."externalId" = '1237457A'
        --    AND cc.type = 'SCO'
        AND ccm."userId" = u.id
    )
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
--    ,u.id
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


-- Certification center membership
SELECT
    ccm.*
FROM "certification-center-memberships" ccm
WHERE 1=1
--    AND ccm.id = 1
   AND ccm."certificationCenterId" = 1
ORDER BY
    ccm.id ASC
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
--    ,u.id
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


DELETE FROM "certification-center-memberships" ccm
WHERE 1=1
  AND ccm.id = 10000005
;



-- profile
-- All
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u."lastTermsOfServiceValidatedAt"
--    u.*
FROM users u
WHERE 1=1
     AND u.id = 106
--    AND u.email LIKE 'geo%@example.net'
ORDER BY
   --u."lastName" ASC
   u."createdAt" DESC
;




-- membership
-- update from MEMBER to ADMIN
UPDATE memberships
SET  "organizationRole" = 'ADMIN'
WHERE id = 201 AND  "organizationRole" = 'MEMBER';


-- membership
-- delete
DELETE FROM memberships
WHERE id = 201 AND  "organizationRole" = 'ADMIN';



