
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
 --o.*
FROM
     organizations o
WHERE 1=1
    AND o.type = 'SCO'
 --   AND o.id = 4
--    AND o.id IN (78, 10, 48, 37)
  --  AND o.name = 'COMPTE DE TEST: SCO #2'
 --   AND o."externalId" = '1237457A'
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

