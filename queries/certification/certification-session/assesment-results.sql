SELECT COUNT(1)
FROM "assessment-results" asr
WHERE 1 = 1
--    AND asr.id = 100010
--    AND asr."assessmentId" = 100008
   AND "createdAt" BETWEEN '2022-02-15 15:00:00.000000 +00:00' AND '2022-02-15 16:00:00.000000 +00:00'
   AND asr.emitter = 'PIX-ALGO-NEUTRALIZATION'
;



-- Results + Session  + Course
SELECT
    'center=>',
    crt.name "centerName",
    'session=>',
    s.id     "sessionId",
    --s."publishedAt" ,
    'course=>',
    cc.id    "certificationCourseId",
    cc."firstName",
    cc."lastName",
    cc."userId",
    u.email,
    cc."lastName",
    cc.birthdate,
    --cc.*,
    'assessments=>',
    ass.id,
    ass.type,
    ass.state,
    'assessments-results=>',
    asr."pixScore",
    asr.emitter,
    asr.status,
    asr."reproducibilityRate",
    asr."createdAt"
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN "assessment-results" asr ON asr."assessmentId" = ass.id
WHERE 1 = 1
   -- AND ass.id = 108510
   --AND ass.state = 'completed'
   --AND asr.status = 'validated'
  AND s.id = 20003
  --AND cc."userId" = 104
  -- AND s."date" = '2022-02-11'
  --   AND s."publishedAt" IS NULL
ORDER BY s.id, cc."userId", asr."createdAt"
;

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
     AND cc."challengeId" = 'receQkwO1dvjQc2S3'
     AND cc."isNeutralized" IS TRUE;