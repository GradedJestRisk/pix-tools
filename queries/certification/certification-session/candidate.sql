-- Candidate
SELECT
     'certification-candidate=>'
    ,crt_cnd.id
    ,crt_cnd."userId"
    ,crt_cnd."sessionId"
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd.birthdate
    ,crt_cnd."authorizedToStart"
    ,crt_cnd."birthINSEECode"
   -- ,'certification-candidates=>'
--   crt_cnd.*
FROM "certification-candidates" crt_cnd
WHERE 1=1
    --AND crt_cnd.id = 106512
    --AND crt_cnd."firstName" = 'first-name'
    --AND crt_cnd."sessionId" = 141595
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
   -- AND crt_cnd."birthINSEECode" = '75001'
   AND crt_cnd."birthINSEECode" IS NULL
   AND crt_cnd."birthPostalCode" IS NULL
;

-- Candidate + session + center
SELECT
    'center=>'
    ,crt_cnt.type
    ,crt_cnt.name
    ,'session=>'
    ,crt_ssn.id
    ,crt_ssn."supervisorPassword"
   -- u.email,
    ,'to-join=>'
    ,crt_ssn.id
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,crt_cnd."birthPostalCode"
    ,crt_cnd."birthINSEECode"
    ,crt_ssn."accessCode"
    ,'candidate=>'
    ,crt_cnd.id
    ,crt_cnd."authorizedToStart"
    ,crt_cnd."userId"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
    AND crt_ssn.id = 6
   -- AND crt_ssn."finalizedAt" IS NULL
--     AND crt_cnd."sessionId" = 141595
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
   -- AND crt_cnd."authorizedToStart" IS TRUE
    --AND crt_cnt."isSupervisorAccessEnabled" IS TRUE
    AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
    AND crt_cnd."birthINSEECode" IS NULL
    AND crt_cnd."birthPostalCode" IS NULL
ORDER BY
    crt_ssn.id, crt_cnd."firstName"
;


-- Candidate + Session + Assesssment + User
SELECT
    'user=>'
    ,u."firstName"
    ,u."lastName"
    ,'candidate=>'
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,crt_cnd."birthPostalCode"
    ,crt_cnd."birthINSEECode"
    ,'course=>'
    ,crt_crs.id
    ,crt_crs."firstName"
    ,crt_crs."lastName"
    ,crt_crs."birthdate"
    ,crt_crs."birthplace"
    ,crt_crs."verificationCode"
   
FROM "certification-candidates" crt_cnd
    INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
    INNER JOIN "certification-courses" crt_crs ON crt_crs."userId" = u.id AND crt_crs."sessionId" = crt_ssn.id
WHERE 1=1
   AND crt_cnd."firstName" <> crt_crs."firstName"
   AND crt_cnd."lastName" <> crt_crs."lastName"
     --AND crt_ssn.id = 6
--     AND crt_cnt.id = 1
    -- AND crt_cnd."sessionId" = 12
   --  AND crt_ssn."finalizedAt" IS NULL
    -- AND ass.state = 'started'
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
;




-- Candidate (not joined session, and session is not finalized)
SELECT
    'center=>'
    ,crt_cnt.type
    ,crt_cnt.name
    ,'session=>'
    ,crt_ssn.id
    ,crt_ssn."supervisorPassword"
   -- u.email,
    ,'to-join=>'
    ,crt_ssn.id "sessionNumber"
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,crt_ssn."accessCode"
    ,'candidate=>'
    ,crt_cnd.id
    ,crt_cnd."authorizedToStart"
    ,crt_cnd."userId"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
   --  AND crt_ssn.id = 2
    AND crt_ssn."finalizedAt" IS NULL
--     AND crt_cnd."sessionId" = 141595
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
   -- AND crt_cnd."authorizedToStart" IS TRUE
    --AND crt_cnt."isSupervisorAccessEnabled" IS TRUE
    --AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
ORDER BY
    crt_ssn.id, crt_cnd."firstName"
;

SELECT COUNT(1)
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
WHERE crt_cnd."createdAt" > crt_ssn."finalizedAt"
;


SELECT
    crt_ssn.id "sessionId",
    crt_cnd.id "candidateId",
    crt_cnd."createdAt" "candidateCreationDate",
    crt_ssn."finalizedAt" "sessionFinalizationDate"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
WHERE crt_cnd."createdAt" > crt_ssn."finalizedAt"
ORDER BY crt_cnd."createdAt" DESC
;


-- Candidate (already joined session, but did not start assessment)
SELECT
    'session=>'
    ,crt_ssn.id
    ,crt_ssn."supervisorPassword"
    ,u.email
    ,'to-join=>'
    ,crt_ssn.id
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,crt_ssn."accessCode"
    ,'foo'
    ,crt_cnd."authorizedToStart"
FROM "certification-candidates" crt_cnd
    INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
    -- AND crt_cnt.id = 2
--     AND crt_cnd."sessionId" = 141595
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_ssn.id = 1
   -- AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
    --AND crt_cnd."firstName" = 'Jean-Pierre'
ORDER BY
    crt_ssn.id, crt_cnd."firstName"
;


UPDATE "certification-candidates" crt_cnd
SET "authorizedToStart" = true
WHERE id = 34000;

SELECT *
FROM sessions crt_ssn
WHERE 1=1
    AND crt_ssn."certificationCenterId" = 1
;

-- Candidate (already joined session)
SELECT
    'session=>'
    ,crt_ssn.id
    ,crt_ssn."supervisorPassword"
   -- u.email,
    ,'to-join=>'
    ,crt_ssn.id
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,crt_ssn."accessCode"
    ,'foo'
    ,crt_cnd."authorizedToStart"
FROM "certification-candidates" crt_cnd
    INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
    INNER JOIN assessments a on u.id = a."userId"
WHERE 1=1
    -- AND crt_cnt.id = 2
--     AND crt_cnd."sessionId" = 141595
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
   -- AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
;


-- Candidate (started, and can still join the session)
SELECT
    'connexion=>',
    u.email,
    u.id,
    'join-session=>',
    crt_ssn.id id_session,
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."birthdate",
    crt_ssn."accessCode",
    crt_cnd."authorizedToStart"
FROM "certification-candidates" crt_cnd
    INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
    INNER JOIN "certification-courses" crt_crs ON crt_crs."userId" = u.id AND crt_crs."sessionId" = crt_ssn.id
    INNER JOIN "assessments" ass ON ass."certificationCourseId" = crt_crs.id
WHERE 1=1
--     AND crt_cnt.id = 1
    -- AND crt_cnd."sessionId" = 3
     AND crt_ssn."finalizedAt" IS NULL
     AND ass.state = 'started'
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
;


-- Candidate which have aborted course (supplied by supervisor)
SELECT
    'session=>'
    ,crt_ssn.id
    ,'center=>'
    ,crt_cnt.type
    ,crt_cnt.name
    ,'candidate=>'
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd."birthdate"
    ,'course'
    ,crt_crs."abortReason"
FROM "certification-candidates" crt_cnd
    INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
    INNER JOIN "certification-courses" crt_crs ON crt_crs."userId" = u.id AND crt_crs."sessionId" = crt_ssn.id
    INNER JOIN "assessments" ass ON ass."certificationCourseId" = crt_crs.id
WHERE 1=1
--     AND crt_cnt.id = 1
    -- AND crt_cnd."sessionId" = 12
   --  AND crt_ssn."finalizedAt" IS NULL
    -- AND ass.state = 'started'
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    --AND u.email = 'certifedu.continue@example.net'
    AND crt_crs."abortReason" IS NOT NULL
;


SELECT
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."birthdate"
    ,crt_cnd."billingMode"
    ,crt_cnd."prepaymentCode"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIn "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
   AND crt_cnt.name = 'Centre SUP des Anne-Étoiles'
   AND crt_cnt.type <> 'SCO'
;

-- Center + Supervisor + candidate access
SELECT
   'center=>',
    crt_cnt.id,
    crt_cnt.name,
 --   crt_cnt.type,
    'session=>',
    crt_ssn.id, crt_ssn."finalizedAt",
    'supervisor=>',
    crt_ssn.id sess_id,
    crt_ssn."supervisorPassword" sup_pwd,
    'candidate=>',
     crt_ssn.id sess_id,
     crt_ssn."accessCode" sess_code,
--    crt_ssn."description",
    crt_cnd.id cnd_id,
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."userId",
    crt_cnd."birthdate",
    crt_cnd."organizationLearnerId",
    crt_cnd."authorizedToStart"
--    crt_cnd."userId"
    ,crt_cnd."billingMode"
    ,crt_cnd."prepaymentCode"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
--     AND crt_cnt.id = 1
 --    AND crt_cnd."sessionId" = 13
    AND crt_cnd."organizationLearnerId" IS NOT NULL
--    AND crt_ssn."supervisorPassword" IS NOT NULL
--    AND crt_cnd."authorizedToStart" IS TRUE
   --AND crt_cnt.type <> 'SCO'
  -- AND crt_cnt.name = 'Centre SUP des Anne-Étoiles'
  --  AND crt_cnt.name ILIKE '%AEFE%'
   --AND crt_ssn."finalizedAt" IS NULL
;


-- Complementary certifications
SELECT *
FROM "complementary-certification-subscriptions" cmp_crt
WHERE 1=1
AND cmp_crt."certificationCandidateId" = 1
;

SELECT
    crt_cnd."firstName" cnd,
    crt_cnd."lastName",
    cmp.name            cmp_ctr_nm  ,
    cmp_crt."createdAt" cmp_crt_crt
FROM "complementary-certification-subscriptions" cmp_crt
    INNER JOIN "certification-candidates" crt_cnd ON crt_cnd.id = cmp_crt."certificationCandidateId"
    INNER JOIN "complementary-certifications" cmp ON cmp.id = cmp_crt."complementaryCertificationId"
;





-------------------
----- Cities ------
-------------------


SELECT
    ct.id,
    ct."postalCode",
    ct."INSEECode",
    ct.name
FROM
    "certification-cpf-cities" ct
WHERE 1=1
    AND ct.name ILIKE '%paris%'
ORDER BY ct."postalCode" ASC
;
--
-- id	postalCode	INSEECode	name
-- 106080	75001	75101	PARIS 1


INSERT INTO "certification-cpf-cities"
(name, "postalCode", "INSEECode", "isActualName")
VALUES ('Poitiers', '86000', '86000', true)
;
