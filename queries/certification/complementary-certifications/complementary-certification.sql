-- Complementary certification
SELECT
    'complementary certification=>'
    ,crt_cmp.id
    ,crt_cmp.name
FROM
 "complementary-certifications" crt_cmp
;

INSERT INTO "complementary-certifications" (name)
VALUES ('Pix+ Edu');

SELECT nextval('complementary-certifications_id_seq');


-- Complementary certification by center
SELECT
   'habilitation=>'
   ,crt_cmp_hbl.id
   ,crt_cmp_hbl."certificationCenterId"
   ,crt_cmp_hbl."complementaryCertificationId"
   ,crt_cmp_hbl."createdAt"
FROM
    "complementary-certification-habilitations" crt_cmp_hbl
ORDER BY
 crt_cmp_hbl."createdAt" DESC
;

-- Certification center + organization
SELECT
    'certification-center=>'
    ,crt_cnt.id
    ,crt_cnt.name
    ,'complementary certification=>'
    ,crt_cmp.id
    ,crt_cmp.name
    ,'habilitation=>'
    ,crt_cmp_hbl."createdAt"
FROM
     "certification-centers" crt_cnt
         INNER JOIN "complementary-certification-habilitations" crt_cmp_hbl ON crt_cmp_hbl."certificationCenterId" = crt_cnt.id
         INNER JOIN "complementary-certifications" crt_cmp ON crt_cmp.id = crt_cmp_hbl."complementaryCertificationId"
WHERE 1=1
    AND crt_cnt.id = 31000
     -- AND crt_cnt.name = 'Centre SCO des Anne-Étoiles'
--    AND cc.type = 'SCO'
--      AND cc."externalId" = '1237457A'
ORDER BY crt_cmp_hbl.id DESC
;

SELECT
    'badges=>'
    ,cmpl_crt_bdg.*
FROM
   "complementary-certification-badges" cmpl_crt_bdg
;

SELECT
    'courses=>'
    ,cmpl_crt_crs.*
FROM
   "complementary-certification-courses" cmpl_crt_crs
WHERE 1=1
   -- AND cmpl_crt_crs
;


SELECT
    'complementary certification=>'
    --,ccc.id
    ,ccc.name
    ,'courses=>'
    ,cc."firstName"
    ,cc."lastName"
    ,cc.birthdate
    ,cc."sessionId"
    ,cc."isPublished"
    --,'complementary-certifications=>'
    --,cc.*
FROM
   "complementary-certification-courses" cmpl_crt_crs
        INNER JOIN "complementary-certifications" ccc ON ccc.id = cmpl_crt_crs."complementaryCertificationId"
        INNER JOIN "certification-courses" cc ON cc.id = cmpl_crt_crs."certificationCourseId"
WHERE 1=1
   AND ccc.name = 'Pix+ Droit'

;



-- badges
SELECT
   'badges=>',
    bdg.id,
    bdg."altMessage",
    'badges=>',
    bdg.*
FROM badges bdg
WHERE 1=1
    AND id = 117
;

INSERT INTO
"complementary-certification-habilitations" (
      id,
      "complementaryCertificationId",
      "certificationCenterId",
      "createdAt"  )
SELECT id,
      "accreditationId",
      "certificationCenterId",
      "createdAt"
FROM "granted-accreditations"
;



-- Certification center + organization (old / DELETE AFTER PR merge)
SELECT
    'certification-center=>'
    ,crt_cnt.id
    ,crt_cnt.name
    ,'complementary certification=>'
    ,crt_cmp.id
    ,crt_cmp.name
    ,'habilitation=>'
    ,crt_cmp_hbl."createdAt"
FROM
     "certification-centers" crt_cnt
         INNER JOIN "granted-accreditations" crt_cmp_hbl ON crt_cmp_hbl."certificationCenterId" = crt_cnt.id
         INNER JOIN "accreditations" crt_cmp ON crt_cmp.id = crt_cmp_hbl."accreditationId"
WHERE 1=1
--    AND cc.id = 1
--      AND cc.name = 'Centre SCO des Anne-Étoiles'
--    AND cc.type = 'SCO'
--      AND cc."externalId" = '1237457A'
ORDER BY crt_cmp_hbl.id DESC
;
