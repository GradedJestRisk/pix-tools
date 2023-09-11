

WITH duplicate AS (
    SELECT
       "sessionId", "firstName", "lastName", "birthdate", COUNT(1)
    FROM "certification-candidates"
    GROUP BY "sessionId", "firstName", "lastName", "birthdate"
    HAVING COUNT(1) > 1 )
SELECT
    crt_cnt.type,
    crt_cnt.name,
    cc."sessionId", cc."firstName", cc."lastName", cc."birthdate", cc."organizationLearnerId", cc."userId"
    ,cc."createdAt"
--    cc.*
FROM "certification-candidates" cc INNER JOIN duplicate ON
    duplicate."sessionId" = cc."sessionId"
    AND duplicate."firstName" = cc."firstName"
    AND duplicate."lastName" = cc."lastName"
    AND duplicate.birthdate = cc.birthdate
    INNER JOIN "sessions" crt_ssn ON cc."sessionId" = crt_ssn.id
    INNER JOIN "certification-centers" crt_cnt ON crt_ssn."certificationCenterId" = crt_cnt.id
WHERE 1=1
    AND crt_ssn."finalizedAt" IS NULL
 --   AND crt_cnt.type <> 'SCO'
  --  AND cc."organizationLearnerId" IS NULL
--ORDER BY cc."sessionId", cc."firstName", cc."lastName", cc."birthdate"
;

SELECT
   "sessionId", "firstName", "lastName", "birthdate", COUNT(1)
FROM "certification-candidates"
WHERE "userId" IS NOT NULL
GROUP BY "sessionId", "firstName", "lastName", "birthdate"
HAVING COUNT(1) > 1;


WITH duplicate AS (
    SELECT
       "sessionId", "firstName", "lastName", "birthdate", COUNT(1)
    FROM "certification-candidates"
    GROUP BY "sessionId", "firstName", "lastName", "birthdate"
    HAVING COUNT(1) > 1 )
SELECT
    MIN("createdAt")
FROM "certification-candidates" cc INNER JOIN duplicate ON
    duplicate."sessionId" = cc."sessionId"
    AND duplicate."firstName" = cc."firstName"
    AND duplicate."lastName" = cc."lastName"
    AND duplicate.birthdate = cc.birthdate
;

ALTER TABLE "certification-candidates"
DROP CONSTRAINT "certification_candidates_sessionid_firstname_lastname_birthdate";


ALTER TABLE "certification-candidates"
ADD CONSTRAINT "certification_candidates_sessionid_firstname_lastname_birthdate" UNIQUE("sessionId", "firstName", "lastName", "birthdate");

-- SCO
INSERT INTO "certification-candidates"
    ("firstName", "lastName", "birthCity", "externalId", birthdate, "sessionId", "extraTimePercentage", "birthProvinceCode", "birthCountry", "userId", email, "resultRecipientEmail", "organizationLearnerId", "birthPostalCode", "birthINSEECode", sex, "authorizedToStart", "billingMode", "prepaymentCode")
VALUES
    ('anne', 'success', 'Ici', 'externalId', '2000-01-01', 2, 0.30, '66', 'France', null, 'somemail@example.net', 'destinaire-des-resulats@example.net', null, '75001', '75101', 'M', false, null, null);

-- DROIT
INSERT INTO public."certification-candidates" ( "firstName", "lastName", "birthCity", "externalId", birthdate, "createdAt", "sessionId", "extraTimePercentage", "birthProvinceCode", "birthCountry", "userId", email, "resultRecipientEmail", "organizationLearnerId", "birthPostalCode", "birthINSEECode", sex, "authorizedToStart", "billingMode", "prepaymentCode")
VALUES ( 'Saul', 'Goodman', 'Ici', 'externalId', '2000-01-01', '2020-01-01 00:00:00.000000 +00:00', 9, 0.30, '66', 'France', null, 'somemail@example.net', null, null, '75001', '75101', 'M', false, null, null);
