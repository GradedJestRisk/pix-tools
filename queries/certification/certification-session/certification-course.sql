-- Course
SELECT
    'certification course =>'
    ,cc.id
    ,cc."sessionId"
    ,cc."userId"
    ,cc."isPublished"
    ,cc."verificationCode" --shared certificate, set at start even when no certification has been approved
 --   ,'certification-courses =>'
 --   ,cc.*
FROM "certification-courses" cc
WHERE 1=1
--    AND cc.id = 18002
   AND cc.id IN (1606997, 1451457)
ORDER BY cc.id
;

-- Course + user + session
SELECT
    'session=>'
    ,s.id
    ,s."certificationCenterId"
    ,'user=>'
    ,u."firstName"
    ,u."lastName"
     ,u.email
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
     ,cc."verificationCode"
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
--    AND cc.id IN (1606997, 1451457)
    --AND cc.id = 200
   --AND cc."verificationCode" IS NULL
    --AND length(cc."verificationCode") <> 10
--      AND cc."abortReason" IS NOT NULL	
ORDER BY cc.id
;


-- Course + user + session + learners
SELECT
    'certification course =>'
    ,s.id session_id
    ,cc.id cc_id
    ,cc."abortReason"
    ,'user =>'
    ,u."firstName"
    ,u."lastName"
    ,u.email user_email
     ,'registration =>'
    ,sr.department, sr."educationalTeam", sr.division, sr.birthdate
    ,'organization=>'
    ,o.id
    ,o.name
  --  ,'http://localhost:4200/certification/' || cc.id || '/results' end_url
    -- ,'certification-course =>'
    -- ,cc."isPublished"
    -- ,cc.*
    --,asr.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN "organization-learners" sr ON sr."userId"= u.id
    INNER JOIN organizations o ON o.id = sr."organizationId"
    INNER JOIN sessions s ON cc."sessionId" = s.id
    INNER JOIN assessments a ON a."certificationCourseId" = cc.id
    INNER JOIN "assessment-results" asr ON asr."assessmentId" = a.id
WHERE 1=1
  --   AND s.id = 4
  --AND cc.id = 1593990
  --  AND s.date = '2022/02/11'
  --  AND s."finalizedAt" IS NULL
    AND asr.status = 'validated'
ORDER BY cc.id
;


select
*
from "certification-candidates"
         inner join "organization-learners"  on "organization-learners"."id" = "certification-candidates"."organizationLearnerId"
where "organization-learners"."organizationId" = 3
;

SELECT
*
FROM "certification-courses"
;


SELECT
*
FROM "certification-issue-reports"
;

select * from "schooling-registrations" sr
WHERE 1=1
    AND sr."userId" = 104924
;

SELECT
*
FROM "certification-challenges"
;

SELECT
*
FROM "certification-cpf-cities"
;


---
UPDATE sessions
SET "supervisorPassword" = 'PIX12'
WHERE "supervisorPassword" IS NOT NULL;
