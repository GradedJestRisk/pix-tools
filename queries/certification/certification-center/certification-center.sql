-- Certification center
SELECT
     cc.id
    ,cc.name
    ,cc.type
    ,cc."isSupervisorAccessEnabled"
    ,'certification-centers=>'
    ,cc.*
FROM "certification-centers" cc
WHERE 1=1
--    AND cc.id = 1
    AND cc.id In (563, 142339)
--    AND cc.type = 'SCO'
--    AND cc.type IS NULL
    --AND cc."externalId" = 'EXTERNAL-ID'
--    AND cc.name = 'Centre PRO des Anne-Étoiles'
--    AND cc."isSupervisorAccessEnabled" IS TRUE
;


-- Certification center + organization
SELECT
    'organization=>'
    ,o.id
    ,o.name
    ,o."externalId"
    ,o.type
    ,o."isManagingStudents"
    ,'certification-center=>'
    ,cc.id
    ,cc.name
--     ,'certification-centers=>'
--     ,cc.*
--     ,'organizations=>'
--     ,o.*
FROM
     "certification-centers" cc INNER JOIN organizations o on cc."externalId" = o."externalId"
WHERE 1=1
   -- AND cc.id = 6
--      AND cc.name = 'Centre SCO des Anne-Étoiles'
 --   AND cc.name ILIKE '%EDU%'
--    AND cc.type = 'SCO'
--    AND o."isManagingStudents" IS FALSE
 --     AND cc."externalId" = 'EXTERNAL-ID'
;

-- CREATE
INSERT INTO "certification-centers" (name, type)
VALUES ('foo', 'SCO');

INSERT INTO "certification-centers" (name, type)
VALUES ('foo', NULL);


UPDATE "certification-centers" SET "isSupervisorAccessEnabled" = TRUE
WHERE name = 'Centre PRO des Anne-Étoiles';
