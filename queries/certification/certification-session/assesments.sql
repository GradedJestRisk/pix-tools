SELECT *
FROM "assessments" ass
WHERE 1 = 1
--    AND asr.id = 100010
--    AND asr."assessmentId" = 100008
 --   AND "createdAt" BETWEEN '2022-02-14 13:00:00.000000 +00:00' AND '2022-02-14 14:00:00.000000 +00:00'
 --   AND emitter = 'PIX-ALGO-NEUTRALISATION'
;


-- Session + user + Assessment
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
    cc."abortReason",
    cc."completedAt",    
    --cc.*,
    'assessments=>',
    ass.id,
    ass.type,
    ass.state
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
WHERE 1 = 1
  --AND s.id IN (4, 13)
  AND s.id = 115635
  --AND cc."userId" = 104
  -- AND s."date" = '2022-02-11'
  --   AND s."publishedAt" IS NULL
  AND cc."abortReason" IS NOT NULL
  AND cc."completedAt" IS NOT NULL
ORDER BY s.id, cc."userId"
;



-- Candidate declared as aborted but going on with answers
SELECT
    'course=>',
    cc.id    "certificationCourseId",
    cc."firstName",
    cc."lastName",
    cc."userId",	
    cc."lastName",
    cc.birthdate,
    cc."createdAt",
    cc."abortReason",
    cc."completedAt"   
    --cc.*,

FROM "certification-courses" cc
WHERE 1 = 1
	AND cc."abortReason" IS NOT NULL
	AND cc."completedAt" IS NOT NULL
ORDER BY cc."createdAt"
;



SELECT
   --COUNT(1)
   MIN(cc."createdAt"),
   MAX(cc."createdAt")
FROM "certification-courses" cc
WHERE 1 = 1
	AND cc."abortReason" IS NOT NULL
	AND cc."completedAt" IS NOT NULL
;

SELECT
   DISTINCT("sessionId")
FROM "certification-courses" cc
WHERE 1 = 1
	AND cc."abortReason" IS NOT NULL
	AND cc."completedAt" IS NOT NULL
;





-- Session + user + Assessment (after scoring)
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
    cc."abortReason",
    cc."completedAt",    
    --cc.*,
    'assessments=>',
    ass.id,
    ass.type,
    ass.state,
    'assessments-results=>',
    asr."pixScore",
    asr.emitter,
    asr.status,
    asr."createdAt"
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN "assessment-results" asr ON asr."assessmentId" = ass.id
WHERE 1 = 1
  --AND s.id IN (4, 13)
  AND s.id = 20001
  --AND cc."userId" = 104
  -- AND s."date" = '2022-02-11'
  --   AND s."publishedAt" IS NULL
ORDER BY s.id, cc."userId", asr."createdAt"
;


