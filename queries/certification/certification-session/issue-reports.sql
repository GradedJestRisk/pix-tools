SELECT * FROM sessions;

SELECT * FROM "certification-issue-reports" r
WHERE 1=1
--    AND r.id = 49000
   -- AND r."certificationCourseId" = 18007
ORDER BY r.id DESC
;



SELECT id, c."sessionId" FROM "certification-courses" c
WHERE id = 18007
;


-- Reports + Sessions
SELECT
    'session=>',
    s.id "id",
    s."finalizedAt",
    --s."juryCommentAuthorId" "juryId",
    --'course=>',
    --c."userId",
    --c."firstName",
    --c."lastName",
    --c.*,
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
  --AND  u."firstName" = 'AnneNormale5'
    AND s.id = 83626
    --AND c.id = 107201
   -- AND r.id = 107193
--     AND c."userId" = 110
   --AND r.category = 'FILE_NOT_OPENING'
   --AND r.subcategory = 'FILE_NOT_OPENING'
--    AND r.description = 'Elle a pas fini sa certif (deuxième fois)'
 --  AND s."finalizedAt" IS NOT NULL
 --  AND r."resolvedAt" IS NULL
   -- AND s."finalizedAt" IS NULL
ORDER BY s.id, r.category, r.description
;


-- Reports + Sessions + Users + Centers

UPDATE "certification-issue-reports" r
SET "resolvedAt" = NULL, resolution = NULL
WHERE r.id = 107202
;
UPDATE "certification-issue-reports"
SET
    category = 'IN_CHALLENGE',
    subcategory = 'UNINTENTIONAL_FOCUS_OUT'
WHERE id = 49000
;





-- Impactful and not resolved
SELECT
    r.id,
    u."firstName",
    u."lastName",
    r.category,
    r.description
FROM "certification-issue-reports" r
    INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
    INNER JOIN "sessions" s ON s.id = c."sessionId"
    INNER JOIN users u ON u.id = c."userId"
WHERE 1=1
  AND  u."firstName" = 'AnneNormale5'
  AND r."resolvedAt" IS NULL
  AND ( r.category IN ('TECHNICAL_PROBLEM' ,'OTHER', 'FRAUD') OR r.subcategory IN ('NAME_OR_BIRTHDATE',
  'LEFT_EXAM_ROOM',
  'IMAGE_NOT_DISPLAYING',
  'EMBED_NOT_WORKING',
  'FILE_NOT_OPENING',
  'WEBSITE_UNAVAILABLE',
  'WEBSITE_BLOCKED',
  'LINK_NOT_WORKING',
  'OTHER',
  'EXTRA_TIME_EXCEEDED',
  'SOFTWARE_NOT_WORKING') )
;

-- Non-impactful or impactful and resolved
SELECT
    r.id,
    u."firstName",
    u."lastName",
    r.category,
    r.description
FROM "certification-issue-reports" r
    INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
    INNER JOIN "sessions" s ON s.id = c."sessionId"
    INNER JOIN users u ON u.id = c."userId"
WHERE 1=1
  --AND  u."firstName" = 'AnneFailure'
  AND r."resolvedAt" IS NOT NULL
  AND (
   r.category NOT IN ('TECHNICAL_PROBLEM' ,'OTHER', 'FRAUD')
  AND r.subcategory NOT IN ('NAME_OR_BIRTHDATE',
  'LEFT_EXAM_ROOM',
  'IMAGE_NOT_DISPLAYING',
  'EMBED_NOT_WORKING',
  'FILE_NOT_OPENING',
  'WEBSITE_UNAVAILABLE',
  'WEBSITE_BLOCKED',
  'LINK_NOT_WORKING',
  'OTHER',
  'EXTRA_TIME_EXCEEDED',
  'SOFTWARE_NOT_WORKING'))
;






SELECT * FROM users WHERE id = 199;

SELECT COUNT(1)
FROM "certification-issue-reports" r
    INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
    INNER JOIN "sessions" s ON s.id = c."sessionId"
WHERE 1=1
    AND s."finalizedAt" IS NOT NULL
    AND r."resolvedAt" IS NULL
;




INSERT INTO public."certification-issue-reports"
    ( "certificationCourseId", category, subcategory, description, "questionNumber",
     resolution, "resolvedAt",
     "createdAt", "updatedAt")
VALUES ( 106852, 'IN_CHALLENGE','UNINTENTIONAL_FOCUS_OUT', NULL , 3,
        NULL, NULL,
        NOW(), NOW()
);



UPDATE "certification-issue-reports"
SET  "resolvedAt" = NOW()
WHERE id IN
(
    SELECT r.id FROM "certification-issue-reports" r
        INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
        INNER JOIN "sessions" s ON s.id = c."sessionId"
    WHERE s."finalizedAt" IS NOT NULL AND r."resolvedAt" IS NULL
);


UPDATE "certification-issue-reports" r
SET  "resolvedAt" = NULL
WHERE id IN
(
    SELECT r.id FROM "certification-issue-reports" r
        INNER JOIN "certification-courses" c ON c.id = r."certificationCourseId"
        INNER JOIN "sessions" s ON s.id = c."sessionId"
    WHERE s."finalizedAt" IS NOT NULL AND r."resolvedAt" BETWEEN (NOW() - interval ' 1 DAYS' ) AND  (NOW() + interval ' 1 DAYS' )
);
