SELECT *
FROM answers a
WHERE 1=1
--    AND a."assessmentId" = 13003
;

-- Session + Answer + Assessment
SELECT
    row_number() over (order by ans."createdAt"),
    crt.name        "centerName",
    s.id            "sessionId",
    'assessment=>',
    ass.id,
    'course=>',
    cc.id,
--     cc."firstName",
    cc."userId",
    cc."lastName",
--     cc.birthdate,
    'answer=>',
    ans.id,
    --ans."createdAt" "answeredAt",
    ans."challengeId",
    ans.value,
    ans.result,
    ans."isFocusedOut"
    ,'answers=>'
    ,ans.*
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
  --AND s.id = 20000
  --AND cc."userId" = 104
  --AND s."date" = '2022-02-11'
  AND cc.id = 1614976
  -- AND ans.result <> 'ok'
  --  AND ans.value <> '#ABAND#'
--   AND ans."createdAt" BETWEEN '2022-02-11 11:00:00.000000 +00:00' AND '2022-02-11 18:00:00.000000 +00:00'
--  AND s."publishedAt" IS NOT NULL
--   AND ans."challengeId" IN ('rec6m0IwAPju8VhXr', 'recC9Bgcmus1udujY')
ORDER BY s.id, cc."userId", ans."createdAt" ASC
;

SELECT '{ result: "' || a.result || '", challengeId: "' || a."challengeId" || '", resultDetails: "' || a.value|| '" },'
FROM answers a
WHERE a."assessmentId" = 13000
;



SELECT
--     crt.name        "centerName",
--     s.id            "sessionId",
--     s.date,
    cc.id "certificationCourseId",
    cc."userId",
    cc."firstName",
  --  cc."lastName",
    --cc.birthdate,
    ans."createdAt" "answeredAt",
    ans.result
--    ans."challengeId"
FROM sessions s
         INNER JOIn "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
    AND s."date" = '2020-01-31'
    AND ans.result <> 'ok'
--  AND ans."createdAt" BETWEEN '2022-02-11 11:00:00.000000 +00:00' AND '2022-02-11 18:00:00.000000 +00:00'
--  AND s."publishedAt" IS NOT NULL
  AND ans."challengeId" IN ('recG8nWow8yP7P3WA', 'rec89GEKgYFZ1vqHr')
;


UPDATE answers
SET
    "isFocusedOut" = TRUE,
    result = '#ABAND#'
WHERE 1=1
    AND "assessmentId" = 13001
    AND id = 14081
;



