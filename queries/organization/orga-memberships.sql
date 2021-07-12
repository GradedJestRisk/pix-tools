-- Roles
SELECT *
FROM pix_roles
;


-- membership
-- given an identifier
SELECT
    m.*
FROM memberships m
WHERE 1=1
--    AND m.id = 1
   AND m."organizationId" = 3
ORDER BY
    m.id ASC
;


-- membership + user + organization
-- given an user/ identifier
SELECT
    'organization=>',
    o.id,
    o.name,
    o."externalId",
    'user=>',
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u.username,
   'membership =>',
--    m.id,
    m."organizationRole",
   'memberships =>',
    m.*
FROM
    memberships m
        INNER JOIN users         u ON m."userId" = u.id
        INNER JOIN organizations o ON m."organizationId" = o.id

WHERE 1=1
  --  AND u.email = 'sco.admin@example.net'
  --  AND u.id = 220610
  --  AND u.username IS NOT NULL
  --  AND m.id = 1
      AND m."organizationRole" = 'ADMIN'
  --  AND o.id = 7930
      AND o.name = 'Collège The Night Watch'
  --  AND o."isManagingStudents" = FALSE
ORDER BY
    m.id ASC
;


-- membership + user + organization
-- access on several organizations
-- given an identifier
SELECT
    u.email,
    COUNT(1)
FROM
    memberships m
        INNER JOIN users u on m."userId" = u.id
        INNER JOIN organizations o on m."organizationId" = o.id
WHERE 1=1
--    AND m.id = 1
   --AND m."organizationId" = 3
GROUP BY
    u.email
HAVING COUNT(1) > 1
ORDER BY
    u.email ASC
;

-- membership
-- update from MEMBER to ADMIN
UPDATE memberships
SET  "organizationRole" = 'ADMIN'
WHERE id = 201 AND  "organizationRole" = 'MEMBER';


-- membership
-- delete
DELETE FROM memberships
WHERE id = 201 AND  "organizationRole" = 'ADMIN';

SELECT
    o.name,
    oi.email,
    oi.status
FROM
    "organization-invitations" oi
        INNER JOIN organizations o on oi."organizationId" = o.id
WHERE 1=1
    AND oi.status =
;

