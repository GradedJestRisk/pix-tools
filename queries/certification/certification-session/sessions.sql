SELECT
   s.id,
   s.address,
   s.examiner,
   s.date,
   s.description,
   s."juryCommentAuthorId",
   'sessions=>',
   s.*
FROM
    sessions s
WHERE 1=1
--  AND s.id = 106658
  --AND s."juryCommentAuthorId" IS NOT NULL
  --  AND date= '2020-01-15'
  --  AND s.description ILIKE '%EDU%'
    --AND
;

select * from users where id = 199;

-- Session + Certification center
SELECT
     cc.id
    ,cc.name
    ,cc.type
    ,cc."isSupervisorAccessEnabled"
    ,s.id
    ,s."supervisorPassword"
    ,'sessions=>'
    ,s.*
FROM "certification-centers" cc
    INNER JOIN sessions s ON s."certificationCenterId" = cc.id
WHERE 1=1
    AND s.id IN(4,13)
--    AND cc.id = 1
--    AND cc.type = 'SCO'
--    AND cc.type IS NULL
--    AND cc."externalId" = '1237457A'
--    AND cc.name = 'Centre PRO des Anne-Étoiles'
 --  AND cc."isSupervisorAccessEnabled" IS TRUE
;

-- Finalized session
SELECT
    fs."sessionId",
    fs."isPublishable",
    fs."publishedAt",
    fs."assignedCertificationOfficerName",
    'finalized-sessions=>',
    fs.*
FROM "finalized-sessions" fs
WHERE 1=1
--    AND "sessionId" = 6
--     AND "isPublishable" IS TRUE
--    AND fs."assignedCertificationOfficerName" IS NOT NULL
;
