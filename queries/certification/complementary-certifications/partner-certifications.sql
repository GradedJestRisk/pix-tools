SELECT *
FROM "partner-certifications"
;



SELECT
    'certification course =>'
    --,s.id session_id
  , cc.id   cc_id
  , u."firstName"
  , u."lastName"
  , u.email user_email
    --  ,'http://localhost:4200/certification/' || cc.id || '/results' end_url
  , 'certification-course =>'
  , cc."isPublished"
  , 'complementary-certifications =>'
  , pc."partnerKey"
  , pc."temporaryPartnerKey"
  , pc.acquired
    -- ,pc.*
FROM "certification-courses" cc
         INNER JOIN "partner-certifications" pc ON pc."certificationCourseId" = cc.id
         INNER JOIN users u ON u.id = cc."userId"
         INNER JOIN sessions s on cc."sessionId" = s.id
WHERE 1 = 1
  AND cc.id = 200
  --  AND u.email = 'certifedu.initiale@example.net'
  --     AND s.id = 5
  --  AND s.date = '2022/02/11'
  --  AND pc."partnerKey" ILIKE 'PIX_EDU_%'
  --  AND pc."temporaryPartnerKey" ILIKE 'PIX_EDU_%'
ORDER BY cc.id
;

UPDATE "partner-certifications"
SET "partnerKey"= null,
    "acquired"  = FALSE
WHERE "certificationCourseId" = 18000;



Badge.keys = {
  PIX_EMPLOI_CLEA: 'PIX_EMPLOI_CLEA',
  PIX_EMPLOI_CLEA_V2: 'PIX_EMPLOI_CLEA_V2',
  PIX_DROIT_MAITRE_CERTIF: 'PIX_DROIT_MAITRE_CERTIF',
  PIX_DROIT_EXPERT_CERTIF: 'PIX_DROIT_EXPERT_CERTIF',
  PIX_EDU_FORMATION_INITIALE_2ND_DEGRE_INITIE: 'PIX_EDU_FORMATION_INITIALE_2ND_DEGRE_INITIE',
  PIX_EDU_FORMATION_INITIALE_2ND_DEGRE_CONFIRME: 'PIX_EDU_FORMATION_INITIALE_2ND_DEGRE_CONFIRME',
  PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_CONFIRME: 'PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_CONFIRME',
  PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_AVANCE: 'PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_AVANCE',
  PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_EXPERT: 'PIX_EDU_FORMATION_CONTINUE_2ND_DEGRE_EXPERT',
};


DELETE
FROM "partner-certifications"
WHERE "certificationCourseId" = 200
;


INSERT INTO "partner-certifications"
    ("certificationCourseId", "partnerKey", "acquired", "temporaryPartnerKey")
VALUES
--    (200, 'PIX_DROIT_MAITRE_CERTIF', 't', NULL)
--    (200, 'PIX_EMPLOI_CLEA', 't', NULL)
    (200, 'PIX_EDU_FORMATION_INITIALE_2ND_DEGRE_INITIE', 'f', NULL)
;