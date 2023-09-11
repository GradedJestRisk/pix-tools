-- https://github.com/1024pix/pix/blob/dev/CHANGELOG.md
-- v3.217.0 (07/06/2022)
-- rocket Amélioration
--
--     #4468 [FEATURE] Empêcher un candidat de continuer sa certification si la session est finalisée (PIX-4815)
--
-- Delivered production in 08/06/2022 - 2:25 pm

-- Event
SELECT
    'session=>'
    ,s.id
    ,s."certificationCenterId"
    ,s."finalizedAt"
    ,s."publishedAt"
    ,'user=>'
    ,u."firstName"
    ,u."lastName"
    ,'certification course =>'
    ,cc."firstName"
    ,cc."lastName"
    ,cc."birthPostalCode"
    ,cc."birthINSEECode"
    ,cc."isCancelled"
    ,cc."completedAt"
    ,cc."isPublished"
    ,cc."abortReason"
    ,cc."completedAt"
    ,cc."updatedAt"
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1=1
--     AND s.id = 97033
--     AND cc.id = 2326927
	AND cc."abortReason" IS NOT NULL
	AND cc."completedAt" IS NOT NULL
	AND TO_CHAR(cc."createdAt", 'YYYY-MM-DD') >= '2022-06-08'
    AND cc."completedAt" > s."finalizedAt"
ORDER BY cc.id
;
-- course
-- abortReason: candidate
-- completedAt : 9/6/2022, 11:24

-- session
-- finalization date: 9/6/2022, 13:54
-- publication date: 10/6/2022, 9:24
-- no answer should be submitted after this timestamp


-- Challenges
SELECT
    crt.name                                                                                   "centerName",
    s.id                                                                                       "sessionId",
    cc."userId",
    cc."firstName",
    'challenges=>',
    ch."challengeId",
    ch."isNeutralized"
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN "certification-challenges" ch ON ch."courseId" = cc.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
WHERE 1 = 1
  AND s.id = 97033
   AND cc.id = 2326927
--   AND ch."isNeutralized" IS TRUE
;

-- Challenges + answers
SELECT
    crt.name                                                                                   "centerName"
    ,s.id                                                                                       "sessionId"
    ,cc."userId"
    ,cc."firstName"
    ,'challenges=>'
    ,ch."challengeId"
    ,ch."isNeutralized"
    ,'answer=>'
    ,ans."createdAt"
    ,ans."challengeId"
    ,ans.result
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN "certification-challenges" ch ON ch."courseId" = cc.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id AND ans."challengeId" = ch."challengeId"
WHERE 1 = 1
  AND cc.id = 2326927
ORDER BY ans."createdAt" ASC
;
-- 47 answers, between 10:22 => 11:24

-- one POST on /api/certification-reports/2326927/abort 13:54:39