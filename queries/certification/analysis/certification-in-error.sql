-- Session 187032

-- Certification in error
-- Course + user + session
SELECT
    'session=>'
    ,s.id
    ,s."certificationCenterId"
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
--    ,'certification-courses=>'
--    ,cc.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1=1
      --  AND s.id In (4,13)
     -- AND s.id = 6
  --  AND s.date = '2022/02/11'
--    AND s."finalizedAt" IS NULL
   AND cc.id IN (2326314, 2326390)
--      AND cc."abortReason" IS NOT NULL
ORDER BY cc.id
;
-- 187032


-- certification OK
-- Course + user + session
SELECT
    'session=>'
    ,s.id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,s."certificationCenterId"
FROM sessions s
WHERE 1=1
    AND s.id = 187032
;
-- finalized: 9/6/2022, 10:02

-- certification OK
-- Course + user + session
SELECT
    'session=>'
    ,s.id
    ,s."finalizedAt"
    ,s."publishedAt"
    ,s."certificationCenterId"
    ,'user=>'
    ,u."firstName"
    ,u."lastName"
    ,'certification course =>'
    ,cc.id
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
--    ,'certification-courses=>'
--    ,cc.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1=1
    AND s.id = 187032
    AND cc."completedAt" IS NOT NULL
    AND cc."abortReason" IS NULL
ORDER BY cc.id
;
-- cc.id: 2326602






-- Is there a global comment ?
SELECT
    'session=>'
    ,s.id
    ,s."certificationCenterId"
    ,s."juryComment"
FROM sessions s
WHERE 1=1
  AND s.id = 187032
  AND s."juryComment" IS NOT NULL
;
-- (0 rows)
-- NO

-- Has some candidate left session prematurely ?
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
    cc."completedAt"
    --cc.*,
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
WHERE 1 = 1
  AND s.id = 187032
  AND cc."abortReason" IS NOT NULL
  AND cc.id IN (2326314, 2326390)
ORDER BY s.id, cc."userId"
;
-- yes, 1


-- Is there any issue report ?
SELECT
    'session=>',
    s.id "id",
    s."finalizedAt",
    'report=>',
    r.id "reportId",
    r.category,
    r.subcategory,
    r."questionNumber",
    r.description,
    --r."certificationCourseId",
    r."resolvedAt"
    --r.resolution
    --,'certification-issue-reports=>'
    --,r.*
FROM "certification-issue-reports" r
    INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
    INNER JOIN "sessions" s ON s.id = c."sessionId"
WHERE 1=1
    AND s.id = 187032
ORDER BY s.id, r.category, r.description
;

-- (0 rows)
-- NO

-- Neither completed, nor cancelled, nor reported as issue
SELECT
    'session=>'
    ,s.id
    ,s."publishedAt"
    ,s."certificationCenterId"
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
    ,'certification-courses=>'
    ,cc.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1=1
   --AND s.id = 187032
   --AND s."publishedAt" IS NOT NULL
   AND cc.id IN (2326314, 2326390)
   AND cc."isCancelled" IS FALSE
   AND cc."completedAt" IS NULL
   AND cc."abortReason" IS NULL
   AND cc."examinerComment" IS NULL
  AND NOT EXISTS (
    SELECT 1 FROM "certification-issue-reports" r
    WHERE r."certificationCourseId" = cc.id
  )
ORDER BY cc.id DESC
;

-- Certification OK
-- answers
SELECT
    crt.name                                                                                   "centerName"
    ,s.id                                                                                       "sessionId"
    ,cc."userId"
    ,cc."firstName"
    ,'answer=>'
    ,ans."createdAt"
    ,ans."challengeId"
    ,ans.result
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
  AND s.id = 187032
  AND cc.id = 2326602
ORDER BY ans."createdAt" ASC
;
-- 18 lines


-- Certification error
-- Answers
SELECT
    crt.name                                                                                   "centerName"
    ,s.id                                                                                       "sessionId"
    ,cc."userId"
    ,cc."firstName"
    ,'answer=>'
    ,ans."createdAt"
    ,ans."challengeId"
    ,ans.result
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
  AND cc.id IN (2326314, 2326390)
ORDER BY cc.id, ans."createdAt" ASC
;

-- 23 / 24 lines


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
    'assessment=>',
    ass.id,
    ass.type,
    ass.state,
    'assessments-result=>',
    asr."pixScore",
    asr.emitter,
    asr.status,
    asr."reproducibilityRate",
    asr."createdAt",
    asr."commentForJury"
--     ,'assessments-result=>'
--     ,asr.*
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
         INNER JOIN "assessment-results" asr ON asr."assessmentId" = ass.id
WHERE 1 = 1
  AND s.id = 187032
   AND cc.id IN (2326314, 2326390, 2326602)
ORDER BY s.id, cc."userId", asr."createdAt"
;