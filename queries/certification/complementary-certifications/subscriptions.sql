-- subscriptions
SELECT *
FROM "complementary-certification-subscriptions" ccs
WHERE 1=1
--    AND ccs."complementaryCertificationId" =
;

ALTER TABLE "complementary-certification-subscriptions"
ADD CONSTRAINT value_unique UNIQUE("complementaryCertificationId", "certificationCandidateId");


-- subscriptions
SELECT
    'candidate=>'
    ,crt_cnd."firstName"
    ,crt_cnd."lastName"
    ,crt_cnd.birthdate
        ,crt_cnd."userId"
    --,crt_cnd.*
    ,cc.name
    --,'complementary-certification-subscriptions=>'
    --,ccs.*
    --,u.email

FROM "complementary-certification-subscriptions" ccs
    INNER JOIN "complementary-certifications" cc ON cc.id = ccs."complementaryCertificationId"
    INNER JOIN "certification-candidates" crt_cnd ON crt_cnd.id = ccs."certificationCandidateId"
    --INNER JOIN users u ON u.id = crt_cnd."userId"
WHERE 1=1
   -- AND crt_cnd."sessionId" = 20000
--    AND ccs."complementaryCertificationId" =
;

