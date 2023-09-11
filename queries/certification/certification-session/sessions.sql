-- session
SELECT
   'session=>'
   ,s.id
   ,s.address
   ,s.examiner
   ,s.date
   ,s.description
   ,s."examinerGlobalComment"
   ,s."juryCommentAuthorId"
   ,s."finalizedAt"
   ,s."publishedAt"
   ,'sessions=>'
   --,s.*
FROM
    sessions s
WHERE 1=1
   --AND s.id = 12
   AND s.id IN (90090, 142339)
  --AND s."juryCommentAuthorId" IS NOT NULL
  --  AND date= '2020-01-15'
  --  AND s.description ILIKE '%EDU%'
;


-- Session + Certification center
SELECT
     'center=>'
    ,cc.id
    ,cc.name
    ,cc.type
    ,cc."isSupervisorAccessEnabled"
    ,'session=>'
    ,s.id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,'sessions=>'
    ,s.*
FROM "certification-centers" cc
    INNER JOIN sessions s ON s."certificationCenterId" = cc.id
WHERE 1=1
--    AND s.id = 12
    AND s."finalizedAt" IS NOT NULL
    AND s."publishedAt" IS NULL
--    AND cc.id = 1
--    AND cc.type = 'SCO'
--    AND cc.type IS NULL
--    AND cc."externalId" = '1237457A'
--    AND cc.name = 'Centre PRO des Anne-Étoiles'
 --  AND cc."isSupervisorAccessEnabled" IS TRUE
;

-- Session to be finalized
SELECT
     'center=>'
    ,cc.id
    ,cc.name
    ,cc.type
    ,cc."isSupervisorAccessEnabled"
    ,'session=>'
    ,s.id
    ,s.description
    ,s."supervisorPassword"
    ,'sessions=>'
    ,s.*
FROM "certification-centers" cc
    INNER JOIN sessions s ON s."certificationCenterId" = cc.id
WHERE 1=1
    --AND s.id = 2
    AND s."finalizedAt" IS NULL
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


-- Finalized session + session
SELECT
    'session=>'
    ,s.id id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,'finalized=>'
    ,fs."sessionId"
    ,fs."isPublishable"
    ,fs."finalizedAt"
    ,fs."publishedAt"
    ,fs."assignedCertificationOfficerName"
    --,'finalized-sessions=>'
    --,fs.*
FROM "finalized-sessions" fs
	INNER JOIN sessions s ON s.id = fs."sessionId"
WHERE 1=1
--   AND "sessionId" = 83626
   AND "sessionId" IN (1606997, 1451457)
--   AND s."publishedAt" IS NOT NULL
--   AND fs."isPublishable" IS FALSE   
;

-- Session with required action before publication
SELECT
    'session=>'
    ,s.id id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,s."examinerGlobalComment"
    ,'finalized=>'
    ,fs."sessionId"
    ,fs."isPublishable"
    ,fs."finalizedAt"
    ,fs."publishedAt"
    ,fs."assignedCertificationOfficerName"
    --,'finalized-sessions=>'
    --,fs.*
FROM "finalized-sessions" fs
	INNER JOIN sessions s ON s.id = fs."sessionId"
WHERE 1=1
--   AND "sessionId" = 83626
--   AND s."publishedAt" IS NOT NULL
   AND s."publishedAt" IS NULL
   AND fs."isPublishable" IS FALSE   
ORDER BY s."publishedAt"   
;

-- Non-publishable session without issue-report
SELECT
    'session=>'
    ,s.id id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,s."examinerGlobalComment"
    ,'finalized=>'
    ,fs."sessionId"
    ,fs."isPublishable"
    ,fs."finalizedAt"
    ,fs."publishedAt"
    ,fs."assignedCertificationOfficerName"
    --,'finalized-sessions=>'
    --,fs.*
FROM "finalized-sessions" fs
	INNER JOIN sessions s ON s.id = fs."sessionId"
WHERE 1=1
--   AND "sessionId" = 83626
--   AND s."publishedAt" IS NOT NULL
   AND fs."isPublishable" IS FALSE
   AND s."publishedAt" IS NULL
   AND NOT EXISTS (
     SELECT 1 
     FROM "certification-courses"  cc
        INNER JOIN "certification-issue-reports" cir ON cir."certificationCourseId" = cc.id
    WHERE cc."sessionId" = s.id    
   )
ORDER BY s."publishedAt"   
;


-- Non-publishable session without issue-report or candidate abort reason
SELECT
    'session=>'
    ,s.id id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,s."examinerGlobalComment"
    ,'finalized=>'
    ,fs."sessionId"
    ,fs."isPublishable"
    ,fs."finalizedAt"
    ,fs."publishedAt"
    ,fs."assignedCertificationOfficerName"
    --,'finalized-sessions=>'
    --,fs.*
FROM "finalized-sessions" fs
	INNER JOIN sessions s ON s.id = fs."sessionId"
WHERE 1=1
--   AND "sessionId" = 83626
--   AND s."publishedAt" IS NOT NULL
   AND fs."isPublishable" IS FALSE
   AND s."publishedAt" IS NULL
   AND NOT EXISTS (
     SELECT 1 
     FROM "certification-courses"  cc
        INNER JOIN "certification-issue-reports" cir ON cir."certificationCourseId" = cc.id
    WHERE cc."sessionId" = s.id    
   )
    AND NOT EXISTS (
     SELECT 1 
     FROM "certification-courses"  cc
     WHERE "abortReason" IS NOT NULL
   )
ORDER BY s."publishedAt"   
;




