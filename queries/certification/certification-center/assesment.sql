-- Assesment
SELECT
     ssm.id          ssm_dtf
    ,ssm."courseId"  crs_dtf
    ,ssm.type
    ,ssm.state
    ,'assessments=>'
    ,ssm.*
FROM assessments ssm
WHERE 1=1
 --   AND ssm.id = 10000000
;


SELECT
    'center=>',
    crt.name        "centerName",
   'session=>',
    s.id            "sessionId",
    'course=>',
    cc.id           "certificationCourseId",
    cc."firstName",
    cc."userId",
    u.email,
    cc."lastName",
    cc.birthdate,
    --cc.*,
    'assessments=>',
    ass.id,
    ass.type,
    ass.state,
     'assessments=>',
     ass.*
FROM sessions s
         INNER JOIN "certification-centers" crt ON crt.id = s."certificationCenterId"
         INNER JOIN "certification-courses" cc ON cc."sessionId" = s.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN assessments ass ON ass."certificationCourseId" = cc.id
WHERE 1 = 1
  AND s."date" = '2022-02-11'
  ;

-- score
SELECT *
FROm "assessment-results" asr
where 1=1
    and asr."assessmentId" = 13003
;



-- Referential
select
       id,
       name
from courses c
where c.id = 'rec7UnJAHSEP3iwi2';
/*      id         |     name     | adaptive | competenceId
-------------------+--------------+----------+--------------
 rec7UnJAHSEP3iwi2 | Test de démo | f        |
(1 row)*/


SELECT COUNT ("answers"."id") as "nb of answers", "users"."id" as "usersId", "users"."email"
FROM answers
INNER JOIN "assessments" ON "answers"."assessmentId" = "assessments"."id"
INNER JOIN "users" ON "assessments"."userId" = "users"."id"
WHERE "assessments"."userId" IN (10000068)
GROUP BY "assessments"."userId", "users"."id"