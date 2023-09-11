-------------------------------------------
-------- QUERY  -------------------------
-------------------------------------------

-- learner
-- given organization / id
SELECT
    'learner=>'
    ,sr.id
    ,sr."nationalStudentId"
    ,sr."organizationId"
    ,sr."userId"
    ,'confirm=>'
    ,sr."firstName"
    ,sr."lastName"
    ,sr.birthdate
    ,'other=>'
    ,sr."division"
    ,'organization-learners =>'
    ,sr.*
FROM
    "organization-learners" sr
WHERE 1=1
  --AND sr.id = 7254023
 -- AND sr."organizationId" = 3
--    AND sr."firstName" = 'user'
--    AND sr."lastName" = 'gar'
--    AND sr.birthdate  = '2010-09-30'
--    AND sr."userId" IS NULL
    AND sr."division" = '5D'
;

-- schooling registration
-- given registration / INE
SELECT
    sr."nationalStudentId",
    sr."organizationId",
    sr."userId",
    sr."firstName",
    sr."lastName",
    sr.birthdate,
    'registration =>',
    sr.*
FROM
    "schooling-registrations" sr
WHERE 1=1
  AND sr."nationalStudentId" = '123456789BB'
--   AND sr."userId" IS NOT NULL
--   AND sr."nationalStudentId" IS NOT NULL
--    AND sr.birthdate  = '2013-07-22'
ORDER BY
   sr."firstName",
    sr."lastName"
;

select * from "schooling-registrations"
where "nationalStudentId" = '123456789CC'
  ;
  and "firstName" = 'Carter'
  ;
  and "lastName" = $3
  and "birthdate" = $4
  and "userId" is not null


-- schooling registration
-- group by organisation
SELECT
    sr."nationalStudentId",
    COUNT(1)
FROM
    "schooling-registrations" sr
WHERE 1=1
  AND sr."organizationId" = 6
--    AND sr."firstName" = 'user'
--    AND sr."lastName" = 'gar'
--    AND sr.birthdate  = '2010-09-30'
GROUP BY
    sr."nationalStudentId"
--HAVING
--    COUNT(1) > 1
ORDER BY
    sr."nationalStudentId"
;


-- schooling registration
-- group by INE
SELECT
    sr."nationalStudentId",
    COUNT(1)
FROM
    "schooling-registrations" sr
WHERE 1=1
  AND sr."organizationId" = 6
--    AND sr."firstName" = 'user'
--    AND sr."lastName" = 'gar'
--    AND sr.birthdate  = '2010-09-30'
GROUP BY
    sr."nationalStudentId"
--HAVING
--    COUNT(1) > 1
ORDER BY
    sr."nationalStudentId"
;

-- schooling registration
-- given user / id
SELECT
    sr."nationalStudentId",
    sr."organizationId",
    sr."userId",
    'schooling-registrations=>',
    sr.*
FROM
    "schooling-registrations" sr
WHERE 1=1
--  AND sr."userId" = 100060
  AND sr."organizationId" = 3
;


-- schooling registration
-- non-reconciled
SELECT
    *
FROM
    "schooling-registrations" sr
WHERE 1=1
    AND sr."organizationId" = 3
    AND sr."userId" IS NULL
;

-- Never-reconciled profile
-- with SAML authentication method
SELECT *
FROM users u
WHERE 1=1
  AND u.id = 100001
  AND u."samlId" IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM "schooling-registrations" sr WHERE sr."userId" = u.id
    )
;

-- Never-reconciled profile
-- for a given organization
SELECT *
FROM users u
WHERE 1=1
--  AND "samlId" IS NOT NULL
  AND username IS NULL
  AND email    IS NULL
  AND NOT EXISTS (
      SELECT 1
      FROM "schooling-registrations" sr INNER JOIN organizations o on sr."organizationId" = o.id
      WHERE 1=1
        AND o.id        = 6
        AND sr."userId" = u.id
    )
;

--  registrations + organization
--  given an organization identifier
SELECT
    'organization =>',
--      o.id,
--      o.name,
 --    o."isManagingStudents" ,
--     'http://localhost:4200/campagnes/' || c.code,
--     'registration =>',
--      --sr."updatedAt",
--     sr.id,
--     sr."userId",
     sr."firstName",
     sr."lastName",
--     sr."preferredLastName",
--     sr.birthdate,
--     sr."nationalStudentId",
--     'schooling-registrations=>',
--     sr.*
    sr."createdAt",
    sr."updatedAt"
FROM
     "organization-learners" sr
        INNER JOIN organizations o on sr."organizationId" = o.id
        INNER JOIN campaigns c on c."organizationId" = o.id
WHERE 1=1
  AND sr.id = 7254023
   -- AND sr."userId"         IS NULL
    --AND sr."organizationId" = 2
--    AND o.id                =  93
    AND o.type              =  'SCO'
    AND o.name              = 'Collège The Night Watch'
 --   AND o."isManagingStudents"   IS true
--    AND sr."lastName" = 'Adam'
  -- AND sr."firstName" = 'ADAM'
  --  AND sr."nationalStudentId" = '123456789CC'
  --AND "nationalStudentId" =
ORDER BY
    sr."createdAt" DESC
;



--  registrations + organization
--  given an organization identifier
SELECT
     o.id, COUNT(1)
FROM
    "schooling-registrations" sr
         INNER JOIN organizations o on sr."organizationId" = o.id
GROUP BY o.id
ORDER BY COUNT(1) DESC
;




-- Profile + registrations  + organization
-- Given a profile identifier
SELECT
     'profile =>'
    ,u.id
    ,u."firstName"
    ,u."lastName"
    ,u.email
    ,u.username
    ,u."createdAt"
    ,'registration =>'
    ,sr.id
    ,sr."firstName"
    ,sr."lastName"
    ,sr.birthdate
    ,sr."nationalStudentId"
    ,DATE(sr."updatedAt")
    ,sr."updatedAt"
    ,'organization =>'
    ,o.id
    -- o.name
FROM
     users u
         INNER JOIN "schooling-registrations" sr ON sr."userId" = u.id
         INNER JOIN organizations o              ON sr."organizationId" = o.id
WHERE 1=1
    --AND sr."organizationId" = 7930
    AND o.type = 'SCO'
   -- AND DATE(sr."updatedAt") = CURRENT_DATE
--    AND u.username IS NOT NULL
--      AND u."firstName" LIKE '%morm%'
    --AND u.email = 'blueivy.carter@example.net'
--    AND u.id   = 100018
  --AND u."samlId" IS  NULL
  --AND u."firstName" = 'user'
   -- AND sr."nationalStudentId" = '123456789BB'
    AND  u.email = 'mormont.lyanna@example.net'
ORDER BY
    u."createdAt" DESC
;


-- Profile + registrations  + organization + authentication
-- Given a profile identifier
SELECT
    'organization =>',
     o.id,
     o.name,
    'profile =>',
     u.id,
     u."firstName",
     u."lastName",
     u.email,
     u.username,
     u."createdAt",
    'authent =>',
     am."identityProvider",
     --am."authenticationComplement",
     am."authenticationComplement"->'shouldChangePassword' "shouldChangePassword",
    'registration =>',
    sr.id,
    sr."firstName",
    sr."lastName",
    sr.birthdate,
    sr."nationalStudentId",
    DATE(sr."updatedAt")
FROM
     users u
         INNER JOIN "schooling-registrations" sr ON sr."userId" = u.id
         INNER JOIN organizations o              ON sr."organizationId" = o.id
         INNER JOIN "authentication-methods" am  ON am."userId" = u.id
WHERE 1=1
    --AND sr."organizationId" = 7930
    AND o.type = 'SCO'
    AND o.name = 'Collège The Night Watch'
   -- AND DATE(sr."updatedAt") = CURRENT_DATE
--    AND u.username IS NOT NULL
--    AND u.email IS NOT NULL
--    AND u.id   = 100018
  --AND u."samlId" IS  NULL
  --AND u."firstName" = 'user'
--    AND sr."nationalStudentId" = '345678901AB'
--    AND  u.email = 'user.pix@example.net'
    AND am."identityProvider" = 'GAR'
ORDER BY
    o.id,
    u."createdAt" DESC
;

-- SR + organization
-- Given an organization + date
SELECT
    'registration =>',
    sr.id,
    sr."firstName",
    sr."lastName",
    sr.birthdate,
    sr."nationalStudentId",
    DATE(sr."updatedAt"),
    sr."updatedAt"
--     'organization =>',
--     o.id,
    -- o.name
FROM
     "schooling-registrations" sr
         INNER JOIN organizations o  ON sr."organizationId" = o.id
WHERE 1=1
    --AND sr."organizationId" = 7930
    AND o.type = 'SCO'
    --AND DATE(sr."updatedAt") = CURRENT_DATE
--    AND u.username IS NOT NULL
--    AND u.email IS NOT NULL
--    AND u.id   = 100018
  --AND u."samlId" IS  NULL
  --AND u."firstName" = 'user'
--    AND sr."nationalStudentId" = '345678901AB'
--    AND  u.email = 'user.pix@example.net'

;


-- Reconciled on an organization, not reconciled on another
-- Given a profile identifier
SELECT
    'organization (reconciled) =>',
     o_reconciled.id,
     o_reconciled.name,
     'user =>',
     u."firstName",
     u."lastName",
     --u."samlId",
     u.email,
     u.username,
    'registration (reconciled) =>',
    sr_reconciled.id,
    sr_reconciled."firstName",
    sr_reconciled."lastName",
    sr_reconciled.birthdate,
    sr_reconciled."nationalStudentId",
    'registration (unreconciled) =>',
    sr_unreconciled."firstName",
    sr_unreconciled."lastName",
    sr_unreconciled.birthdate,
    sr_unreconciled."nationalStudentId",
    'organization (unreconciled) =>',
    o_unreconciled.id,
    o_unreconciled.name
FROM
     organizations o_reconciled
         INNER JOIN "schooling-registrations" sr_reconciled ON sr_reconciled."organizationId" = o_reconciled.id
         INNER JOIN users u ON u.id = sr_reconciled."userId"
            INNER JOIN "schooling-registrations" sr_unreconciled
                ON sr_unreconciled."nationalStudentId" = sr_reconciled."nationalStudentId"
                   AND sr_unreconciled."organizationId" <> sr_reconciled."organizationId"
                   AND sr_unreconciled."userId" IS NULL
                INNER JOIN "organizations" o_unreconciled ON o_unreconciled.id = sr_unreconciled."organizationId"
WHERE 1=1
  --  AND o."organizationId" = 3
--  AND u.id = 100062
  --AND u."samlId" IS  NULL
  --AND u."firstName" = 'user'
--    AND sr."nationalStudentId" = '345678901AB'
--    AND  u.email = 'user.pix@example.net'
ORDER BY
     o_reconciled.id ASC
;



-- Reconciled profile on a single organization
-- with SAML authentication method
SELECT
    u.id,
    COUNT(1)
FROM users u INNER JOIN "schooling-registrations" sr ON sr."userId" = u.id
WHERE 1=1
--  AND u.id = 100001
  AND u."samlId" IS NOT NULL
GROUP BY
    u.id
HAVING
    COUNT (1) = 1
;


-- Reconciled profile on a several organizations
SELECT
    u.id,
    COUNT(1)
FROM users u
    INNER JOIN "schooling-registrations" sr ON sr."userId" = u.id
WHERE 1=1
--  AND u.id = 100001
--  AND u."samlId" IS NOT NULL
GROUP BY
    u.id
HAVING
    COUNT (1) > 1
;

-- Reconciled profile on a several organizations
-- with SAML authentication method
SELECT
    u.id,
    u.email,
    COUNT(1)
FROM users u
    INNER JOIN "schooling-registrations" sr ON sr."userId" = u.id
WHERE 1=1
--  AND u.id = 100001
--  AND u."samlId" IS NOT NULL
GROUP BY
    u.id, U.email
HAVING
    COUNT (1) > 1
;



-- Reconciled on another organization
-- Given a profile identifier
SELECT
    'organization (reconciled) =>',
     o_reconciled.id,
     o_reconciled.name,
     'user =>',
     u."firstName",
     u."lastName",
     --u."samlId",
     u.email,
     u.username,
    'registration (reconciled) =>',
    sr_reconciled.id,
    sr_reconciled."firstName",
    sr_reconciled."lastName",
    sr_reconciled.birthdate,
    sr_reconciled."nationalStudentId",
    sr_reconciled."MEFCode"
FROM
     organizations o_reconciled
         INNER JOIN "schooling-registrations" sr_reconciled ON sr_reconciled."organizationId" = o_reconciled.id
         INNER JOIN users u ON u.id = sr_reconciled."userId"
WHERE 1=1
   --   AND sr_reconciled."MEFCode" = '10310019110'
     -- AND sr_reconciled."MEFCode" = '3'
  --  AND o."organizationId" = 3
  AND u.id = 100036
  --AND u."samlId" IS  NULL
  --AND u."firstName" = 'user'
--    AND sr."nationalStudentId" = '345678901AB'
--    AND  u.email = 'user.pix@example.net'
ORDER BY
     o_reconciled.id ASC
;


SELECT
    COUNT(1)
FROM
     organizations o_reconciled
         INNER JOIN "schooling-registrations" sr_reconciled ON sr_reconciled."organizationId" = o_reconciled.id
         INNER JOIN users u ON u.id = sr_reconciled."userId"
WHERE 1=1
      AND sr_reconciled."MEFCode" = '10310019110'
;


-- SELECT
--        eleves3e."firstName",
--        elevesAutresOrgas."firstName", *
SELECT
    COUNT(1)
FROM
     "schooling-registrations" elevesAutresOrgas,
    (SELECT u."id", sr."organizationId", sr."firstName", sr."nationalStudentId"
    FROM "users" u
    inner join "schooling-registrations" sr ON u."id" = sr."userId"
    WHERE sr."MEFCode" = '10310019110') eleves3e
WHERE 1=1
    AND elevesAutresOrgas."userId" = eleves3e.id
    AND elevesAutresOrgas."organizationId" <> eleves3e."organizationId"
    AND elevesAutresOrgas."nationalStudentId" <> eleves3e."nationalStudentId"
;

-- Invalid INE / INA
SELECT
       t."nationalStudentId",
       t."userId",
       t."createdAt"
FROM "schooling-registrations" t
WHERE 1=1
    AND t."nationalStudentId" IS NOT NULL
    AND NOT (  t."nationalStudentId" ~ '^[0-9]{9}[a-zA-Z]{2}'
           OR  t."nationalStudentId" ~ '^[0-9]{10}[a-zA-Z]{1}')
ORDER BY
         t."createdAt" DESC
;



-------------------------------------------
-------- COMMAND  -------------------------
-------------------------------------------



-- Reconciliate

SELECT
    sr.*
FROM
    "schooling-registrations" sr
WHERE 1=1
--    AND sr."userId" IS NULL
    AND sr."userId" = 100039
;

UPDATE "schooling-registrations"
SET "userId" =  (SELECT id FROM users u WHERE u."samlId" IS NOT NULL AND u."lastName" = 'gar')
WHERE "organizationId" = 3 AND "firstName" = 'First';



UPDATE "schooling-registrations"
SET "userId" =  100039, "nationalStudentId" = '123456789DD'
WHERE 1=1
  AND id = 100065
  --AND "userId" IS NOT NULL
;


-- Unlink
UPDATE "schooling-registrations"
SET "userId" =  NULL
WHERE 1=1
  AND id = 33182
  AND "userId" IS NOT NULL
--  AND "organizationId" = 6
--  AND "firstName" = 'John'
;


-- Update INE
UPDATE "schooling-registrations"
SET "nationalStudentId" =  'TOTO'
WHERE 1=1
  AND "organizationId" = 6
  AND "firstName" = 'Lyanna'
  AND  id = 100070
;

-- Update INE
-- on id
UPDATE "schooling-registrations"
SET "nationalStudentId" =  'TOTO'
WHERE 1=1
  AND  id = 100026
;


SELECT DISTINCT o.id, o.name, ol.division
FROM "organization-learners" ol
    INNER JOIN organizations o on ol."organizationId" = o.id
WHERE 1=1
AND ol.division LIKE '%+%'
AND ol."userId" IS NULL
;

-- Update INE
-- on id
UPDATE "organization-learners"
SET "division" =  'a+b'
WHERE 1=1
  AND id = 99
  AND division = '2,00E+02'
;




-- schooling registration
-- insert
INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('user1', 'user1', 'user1', '01-01-2000', NULL, 3)
 ;

-- schooling registration
-- insert
INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('user2', 'user2', 'user2', '01-01-2000', NULL, 3)
 ;



-- schooling registration
-- delete
DELETE FROM
    "schooling-registrations"
WHERE 1=1
--    AND "organizationId" IS NULL
    AND id = 100016
 ;
