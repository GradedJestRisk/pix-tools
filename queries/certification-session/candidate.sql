
SELECT
    crt_cnd.id,
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."authorizedToStart",
    'certification-candidates=>',
    crt_cnd.*
FROM "certification-candidates" crt_cnd
WHERE 1=1
    AND crt_cnd."sessionId" = 2
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
;

UPDATE "certification-candidates" crt_cnd
SET "authorizedToStart" = true
WHERE id = 104769;

SELECT *
FROM sessions crt_ssn
WHERE 1=1
    AND crt_ssn."certificationCenterId" = 1
;

-- Candidate (join session)
SELECT
   -- u.email,
    crt_ssn.id id_session,
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."birthdate",
    crt_ssn."accessCode",
    crt_cnd."authorizedToStart"
FROM "certification-candidates" crt_cnd
   -- INNER JOIN users u ON u.id = crt_cnd."userId"
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
--     AND crt_cnt.id = 1
    -- AND crt_cnd."sessionId" = 2
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
    --AND crt_ssn."supervisorPassword" IS NOT NULL
    --AND crt_cnd."authorizedToStart" IS TRUE
    AND crt_cnt.type <> 'SCO'
;


-- Supervisor
SELECT
    crt_cnt.name,
    crt_cnt.type,
    crt_ssn.id id_session,
    crt_ssn."supervisorPassword" mdp_surv,
--    crt_ssn."description",
    crt_cnd."firstName",
    crt_cnd."lastName",
    crt_cnd."userId",
    crt_cnd."schoolingRegistrationId",
    crt_cnd."authorizedToStart",
    crt_cnd."userId"
FROM "certification-candidates" crt_cnd
    INNER JOIN "sessions" crt_ssn ON crt_cnd."sessionId" = crt_ssn.id
    INNER JOIn "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
--     AND crt_cnt.id = 1
 --    AND crt_cnd."sessionId" = 2
--    AND crt_cnd."schoolingRegistrationId" IS NOT NULL
--    AND crt_ssn."supervisorPassword" IS NOT NULL
--    AND crt_cnd."authorizedToStart" IS TRUE
   AND crt_cnt.type <> 'SCO'
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

