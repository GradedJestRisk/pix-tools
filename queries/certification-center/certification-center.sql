-- Certification center
SELECT
     cc.id
    ,cc.name
    ,cc.type
    ,'certification-centers=>'
    ,cc.*
FROM "certification-centers" cc
WHERE 1=1
--    AND cc.id = 1
--    AND cc.type = 'SCO'
    AND cc.type IS NULL
--    AND cc."externalId" = '1237457A'
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
    ,'certification-centers=>'
    ,cc.*
    ,'organizations=>'
    ,o.*
FROM
     "certification-centers" cc INNER JOIN organizations o on cc."externalId" = o."externalId"
WHERE 1=1
--    AND cc.id = 1
--      AND cc.name = 'Centre SCO des Anne-Étoiles'
--    AND cc.type = 'SCO'
--      AND cc."externalId" = '1237457A'
;

-- CREATE
INSERT INTO "certification-centers" (name, type)
VALUES ('foo', 'SCO');

INSERT INTO "certification-centers" (name, type)
VALUES ('foo', NULL);