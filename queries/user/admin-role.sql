-- role
-- SUPER_ADMIN
-- SUPPORT
-- METIER
-- CERTIF

-- Role
SELECT *
FROM "pix-admin-roles"
;

-- Role + user
SELECT
   ur.role,
   u.email
FROM "pix-admin-roles" ur
    INNER JOIN users u on ur."userId" = u.id
WHERE 1=1
    AND u.email IS NOT NULL
ORDER BY
   ur.role, u.email
;

SELECT email, id
FROM users
WHERE email ILIKE 'pierre.top@octo.com';



-----------------------------------------------
------
---------------------------------------------------

INSERT INTO
   "pix-admin-roles" ("userId", "role")
VALUES
   (670450, 'SUPER_ADMIN')
;


DELETE FROM "pix-admin-roles"
WHERE "userId" = 670450 AND "role" = 'SUPER_ADMIN'
;


