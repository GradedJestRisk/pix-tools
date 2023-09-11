-- challenges
SELECT
    cc.id,
    cc."courseId" "certificationCourseId",
    cc."challengeId",
    cc."isNeutralized",
    cc."updatedAt",
    'certification-challenges=>',
    cc.*
FROM "certification-challenges" cc
WHERE 1=1
     --AND cc."courseId" = 106994
     AND cc."challengeId" IN ('recG8nWow8yP7P3WA', 'rec89GEKgYFZ1vqHr')
     AND cc."isNeutralized" IS TRUE
;

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
  AND s.id = 187032
   AND cc.id IN (2326314, 2326390, 2326602)
--   AND cc."userId" = 104
--   AND ch."isNeutralized" IS TRUE
;

-- Answered challenges
SELECT
    crt.name                                                                                   "centerName"
    ,s.id                                                                                       "sessionId"
    ,cc."userId"
    ,cc."firstName"
    ,'challenges=>'
    ,ch."challengeId"
    ,ch."isNeutralized"
    ,'answer=>'
     ,ans."createdAt"                                                                            "answeredAt"
     ,ans."challengeId"
     ,ans.result
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN "certification-challenges" ch ON ch."courseId" = cc.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans ON ans."assessmentId" = ass.id AND ans."challengeId" = ch."challengeId"
WHERE 1 = 1
 -- AND s.id = 13
--   AND cc."userId" = 104
--   AND ch."isNeutralized" IS TRUE
   AND cc.id IN (1606997, 1451457)
;




-- Challenges + answers + results
SELECT
    crt.name                                                                                   "centerName",
    s.id                                                                                       "sessionId",
    cc."userId",
    cc."firstName",
    'challenges=>',
    ch."challengeId",
    ch."isNeutralized",
    'answer=>',
--     ans."createdAt"                                                                            "answeredAt",
--     ans."challengeId",
--     ans.result
    'results=>',
    asr.status,
    asr."pixScore"
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN "certification-challenges" ch ON ch."courseId" = cc.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
         INNER JOIN "assessment-results" asr ON asr."assessmentId" = ass.id
WHERE 1 = 1
 -- AND s.id = 13
--   AND cc."userId" = 104
--   AND ch."isNeutralized" IS TRUE
   AND cc.id IN (1606997, 1451457)
;
