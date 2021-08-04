
-- Account recovery demand
SELECT acd.id
     , acd."userId"
     , acd."oldEmail"
     , acd."newEmail"
     , acd.used
     , acd."createdAt"
     , acd."schoolingRegistrationId"
      , 'http://localhost:4200/recuperer-mon-compte/' || acd."temporaryKey" AS url
--     , 'https://app-pr3263.review.pix.fr/recuperer-mon-compte/' || acd."temporaryKey" AS url
     , 'account-recovery-demands=>'
     , acd.*
FROM
     "account-recovery-demands" acd
WHERE 1=1
--    AND acd."userId" IS NOT NULL
;

-- Change user
UPDATE    "account-recovery-demands" acd
SET "userId" = -1 * "userId"
;

-- Change date (expiration)
UPDATE    "account-recovery-demands" acd
--SET "createdAt" = "createdAt" - interval '3 DAYS'
--SET "createdAt" = NOW()
SET "createdAt" = "createdAt" + interval '3 DAYS'
WHERE id = 10000000
;

-- Change usage
UPDATE    "account-recovery-demands" acd
--SET used = true
SET used = false
WHERE id = 10000000
;

ALTER TABLE "account-recovery-demands"
ADD CONSTRAINT account_recovery_demands_temporary_key_unique UNIQUE("temporaryKey");

ALTER TABLE "account-recovery-demands"
DROP CONSTRAINT account_recovery_demands_temporary_key_unique
;

ALTER TABLE "account-recovery-demands"
ADD CONSTRAINT value_unique UNIQUE("userId", "createdAt", "temporaryKey");


-- -- Profile + registrations  + organization
-- -- Given a profile identifier
SELECT
     'recovery-demand =>'
    ,acd.*
    ,'registration =>'
    ,sr.id
    ,sr."firstName"
    ,sr."lastName"
    ,sr.birthdate
    ,sr."nationalStudentId"
    ,'organization =>'
    ,o.id
    ,o.name
FROM
    "account-recovery-demands" acd
         INNER JOIN "schooling-registrations" sr ON sr.id = acd."schoolingRegistrationId"
         INNER JOIN organizations o              ON sr."organizationId" = o.id
WHERE 1=1
    AND sr."nationalStudentId" = '123456789BB'
  ;
    AND u."firstName" = 'Blue Ivy'
ORDER BY
    u."firstName" ASC
-- ;



-- Account recovery demand + user

SELECT
      u.id
     ,u."firstName"
     ,u.email
     ,acd.id
     , acd."userId"
     , 'account-recovery-demands=>'
     , acd.*
FROM
     "account-recovery-demands" acd
        INNER JOIN users u ON u.id = acd."userId"
;

DELETE FROM "account-recovery-demands"
WHERE "userId" =  9912;



