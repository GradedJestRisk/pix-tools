
select * from assessments
;

select * from "campaign-participations" cp
where cp."userId" = 100060
;

select * from "campaign-participations" cp
where cp."campaignId" = 9
;


-- User + Campaign
SELECT
    'user=>',
    u.id,
    u."firstName",
    u."lastName",
    u.email,
   'campaign=>',
    c.code,
    'participation=>',
    cp.*
FROM
   users u
   INNER JOIN "campaign-participations" cp ON cp."userId" = u.id
   INNER JOIN campaigns c ON  c.id = cp."campaignId"
WHERE 1=1
--    AND u.id = 1
--     AND cp."campaignId" = 9
;


-- Campaign + user + Answers
SELECT
    'organization=>',
    o.id,
    o.name,
    o."isManagingStudents",
    'campaign=>',
    c.code,
    'user=>',
    u."firstName",
    u."lastName",
    u.email,
    'participation=>',
--    cp.*
 -- 'http://localhost:4200/campagnes/' || c.code || '/evaluation/resultats/' || a.id,
    'assesment=>' a,
    a.id,
    a.state,
    a."createdAt",
    'answers=>',
    ans.id,
    ans.value,
    ans.result
--    ,ans.*
FROM
   "campaign-participations" cp
        INNER JOIN assessments a ON a."campaignParticipationId" = cp.id
        INNER JOIN answers ans ON ans."assessmentId" = a.id
        INNER JOIN campaigns c ON c.id = cp."campaignId"
        INNER JOIN organizations o ON o.id = c."organizationId"
        INNER JOIN users u on cp."userId" = u.id
WHERE 1=1
    AND u.id = 104875
--     AND cp."campaignId" = 9
;

select * from answers;
select * from assessments;


-- Campaign + user + Answers
SELECT
    'organization=>',
    o.name,
    o."isManagingStudents",
    'campaign=>',
    c.code,
    'user=>',
    u."firstName",
    u."lastName",
    u.email,
    'participation=>',
--    cp.*
 -- 'http://localhost:4200/campagnes/' || c.code || '/evaluation/resultats/' || a.id,
    'assesment=>' a,
    a.id,
    a.state,
    a."createdAt",
    'answers=>',
    ans.id,
    ans.value,
    ans.result
--    ,ans.*
FROM
   "campaign-participations" cp
        INNER JOIN assessments a ON a."campaignParticipationId" = cp.id
        INNER JOIN answers ans ON ans."assessmentId" = a.id
        INNER JOIN campaigns c ON c.id = cp."campaignId"
        INNER JOIN organizations o ON o.id = c."organizationId"
        INNER JOIN users u on cp."userId" = u.id
WHERE 1=1
    AND o.id = 1
--    AND u.id = 104875
--     AND cp."campaignId" = 9
;



-- Answers on user <> reconciled
SELECT
    o.id,
    o.type,
    o."isManagingStudents"
FROM
   "campaign-participations" cp
        INNER JOIN assessments a ON a."campaignParticipationId" = cp.id
        INNER JOIN answers ans ON ans."assessmentId" = a.id
        INNER JOIN campaigns c ON c.id = cp."campaignId"
        INNER JOIN organizations o ON o.id = c."organizationId"
        INNER JOIN users u on cp."userId" = u.id
WHERE 1=1
--    AND o.id = 1
--    AND o.type = 'SCO'
--    AND o."isManagingStudents" IS TRUE
--    AND u.id = 104875
--     AND cp."campaignId" = 9
    AND NOT EXISTS (
        SELECT 1
        FROM "schooling-registrations" sr
        WHERE sr."userId" = u.id
    )
;