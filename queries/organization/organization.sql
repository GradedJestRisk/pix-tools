
-- organization
-- given an identifier
SELECT
  o.id,
  o.name,
  o.type,
  o."isManagingStudents",
  o."externalId",
  o."logoUrl"
 --'organization => ',
 --,o.*
FROM
     organizations o
WHERE 1=1
    --AND o.type = 'SCO'
 --   AND o.id = 4
--    AND o.id IN (78, 10, 48, 37)
  --  AND o.name = 'COMPTE DE TEST: SCO #2'
 --   AND o."externalId" = '1237457A'
    AND o."externalId" = 'EXABC123'
ORDER BY
    o.id ASC
LIMIT 10
;

-- organization
-- disable student authentication
UPDATE organizations
SET "isManagingStudents" = FALSE
;

-- organization
-- update externalId
UPDATE organizations o
SET "externalId" = '1237457A'
WHERE o.id = 3
;





-- organization
-- managing students
SELECT
  o.id,
  o.name,
  o.type,
  o."isManagingStudents",
 'organization => ',
 o.*
FROM
     organizations o
WHERE 1=1
    AND o.id = 6
 --   AND o.name = 'Dragon & Co'
   AND o."isManagingStudents" = true
;



-- organization
SELECT
    o."externalId",
    COUNT(1)
FROM
     organizations o
WHERE 1=1
    AND o."externalId" IS NOT NULL
GROUP BY
    o."externalId"
HAVING COUNT(1) > 1
;


-- organization
SELECT
    o."externalId",
    o.type,
    COUNT(1)
FROM
     organizations o
WHERE 1=1
    AND o."externalId" IS NOT NULL
    AND o."archivedAt" IS NULL
GROUP BY
    o."externalId", o.type
HAVING COUNT(1) > 1
;


ALTER TABLE organizations
ADD CONSTRAINT "unique_organization_external-id" UNIQUE(type, "externalId")
;

SELECT
    'organization'
    ,o.id
    ,o.name
    ,o.type
    ,o."externalId"
    ,o."isManagingStudents"
    ,o."archivedAt"
   -- 'organization => ',
   -- o.*
FROM organizations o
WHERE 1 = 1
  AND o."externalId" IN (
                         '90186617800014'
                         '22170001600738',
                         '26770275100020',
                         '89042165400017',
                         '82422814200017')
;




--
SELECT *
FROM tags;


-- organization + tags
SELECT
 'organization => ',
  o.id,
  o.name,
  o.type,
  o."isManagingStudents",
 'tags => ',
  t.name
FROM
     organizations o INNER JOIN "organization-tags" ot ON ot."organizationId" = o.id
         INNER JOIN tags t ON t.id = ot."tagId"
WHERE 1=1
--    AND o.id = 4
;

-- organization + tags
-- More than one tag
SELECT
  o.name,
  COUNT(1)
FROM
     organizations o INNER JOIN "organization-tags" ot ON ot."organizationId" = o.id
         INNER JOIN tags t ON t.id = ot."tagId"
WHERE 1=1
--    AND o.id = 4
GROUP BY o.name
HAVING COUNT(1) > 1
;


-- organization + tags if exists
SELECT
    t.name TAG,
    CASE WHEN ot."organizationId" IS NULL THEN 'YES' ELSE 'NO' END IS_ASSIGNED
FROM
    tags t LEFT OUTER JOIN "organization-tags" ot ON t.id = ot."tagId"
WHERE 1=1
    AND ( ot."organizationId" = 8 OR ot."organizationId" IS NULL)
;


SELECT
    t.name,
    ot."organizationId"
FROM
    "organization-tags" ot  RIGHT OUTER JOIN tags t ON t.id = ot."tagId"
WHERE 1=1
--    AND ot.id = 8
;






select * from  "target-profiles"
;

select * from"target-profile-shares"
;

