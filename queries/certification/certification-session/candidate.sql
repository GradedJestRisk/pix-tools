
SELECT
    crt_cnd.id,
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."authorizedToStart",
    'certification-candidates=>',
    crt_cnd.*
FROM "certification-candidates" crt_cnd
WHERE 1=1
    AND crt_cnd."sessionId" = 20000
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
;

UPDATE "certification-candidates" crt_cnd
SET "authorizedToStart" = true
WHERE id = 34000;

SELECT *
FROM sessions crt_ssn
WHERE 1=1
    AND crt_ssn."certificationCenterId" = 1
;

-- Candidate (join session)
SELECT
    'session=>'n,
    crt_ssn.id,
    crt_ssn."supervisorPassword",
   -- u.email,
    'candidate=>',
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
WHERE 1=1
--     AND crt_cnt.id = 1
    -- AND crt_cnd."sessionId" = 2
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_cnd."authorizedToStart" IS TRUE
   -- AND crt_cnt.type <> 'SCO'
    AND u.email = 'certifedu.continue@example.net'
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
--    crt_cnd."schoolingRegistrationId",
    crt_cnd."authorizedToStart"
--    crt_cnd."userId"
    ,crt_cnd."billingMode"
    ,crt_cnd."prepaymentCode"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
--     AND crt_cnt.id = 1
     AND crt_cnd."sessionId" = 13
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
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
