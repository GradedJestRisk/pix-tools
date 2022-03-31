
SELECT
    'certification course =>'
    ,cc.id
    ,cc."sessionId"
    ,cc."userId"
    ,cc."isPublished"
    ,cc."verificationCode" --shared certificate, set at start even when no certification has been approved
    ,'certification-courses =>'
    ,cc.*
--     ,'certification-course =>'
--     ,cc.*
FROM "certification-courses" cc
WHERE 1=1
--    AND cc.id = 18002
ORDER BY cc.id
;

-- Course + user + session
SELECT
    'certification course =>'
    ,s.id session_id
    ,cc.id cc_id
    ,u."firstName"
    ,u."lastName"
    ,u.email user_email
  --  ,'http://localhost:4200/certification/' || cc.id || '/results' end_url
     ,'certification-course =>'
     ,cc."isPublished"
     ,cc.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1=1
        AND s.id In (4,13)
      --AND s.id = 5
  --  AND s.date = '2022/02/11'
    AND s."finalizedAt" IS NULL
ORDER BY cc.id
;


-- Course + user + session
SELECT
    'certification course =>'
    ,s.id session_id
    ,cc.id cc_id
    ,'user =>'
    ,u."firstName"
    ,u."lastName"
    ,u.email user_email
     ,'registration =>'
    ,sr.department, sr."educationalTeam", sr.division
    ,'organization'
    ,o.name
  --  ,'http://localhost:4200/certification/' || cc.id || '/results' end_url
    -- ,'certification-course =>'
    -- ,cc."isPublished"
    -- ,cc.*
FROM "certification-courses" cc
    INNER JOIN users u ON u.id = cc."userId"
    INNER JOIN "organization-learners" sr ON sr."userId"= u.id
    INNER JOIN organizations o ON o.id = sr."organizationId"
    INNER JOIN sessions s ON cc."sessionId" = s.id
WHERE 1=1
     AND s.id = 4
  --  AND s.date = '2022/02/11'
  --  AND s."finalizedAt" IS NULL
ORDER BY cc.id
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