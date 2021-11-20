

-- Roles
SELECT id, name
FROM "pix_roles"
;
-- PIX_MASTER
-- PIX_READER

-- Roles - user
SELECT *
FROM "users_pix_roles"
;

-- Role + user
-- Given a role
SELECT
    u.email,
    r.name,
    COUNT(1)
FROM "users_pix_roles" ur
    INNER JOIN users u on ur.user_id = u.id
    INNER JOIN pix_roles r on ur.pix_role_id = r.id
WHERE 1=1
    AND u.email IS NOT NULL
GROUP BY  u.email, r.name
HAVING COUNT(1) > 1
;

-- Role + user
-- Given a role
SELECT
    u.email,
    r.name
FROM "users_pix_roles" ur
    INNER JOIN users u on ur.user_id = u.id
    INNER JOIN pix_roles r on ur.pix_role_id = r.id
WHERE 1=1
    AND r.name = 'PIX_MASTER'
;




-----------------------------------------------


-- Set user as PIX_MASTER
SELECT id FROM users WHERE email = 'pierre.top@pix.fr'
;
--100008

INSERT INTO "users_pix_roles" (user_id, pix_role_id)
VALUES (10000002, 1)
;

ALTER TABLE users_pix_roles
ADD CONSTRAINT test UNIQUE (user_id, pix_role_id)
;

ALTER TABLE users_pix_roles
DROP CONSTRAINT test
;


--

DELETE
FROM "users_pix_roles" ur
WHERE 1=1
 AND ur.user_id  IN (
    974914,
    252289,
    211766)
RETURNING *
;

DELETE
FROM "users_pix_roles" ur
WHERE 1=1
 AND ur.pix_role_id = (SELECT id FROM  "pix_roles" WHERE name = 'PIX_MASTER')
 AND ur.user_id IN (
    SELECT u.id
    FROM "users_pix_roles" ur
             INNER JOIN users u on ur.user_id = u.id
             INNER JOIN pix_roles r on ur.pix_role_id = r.id
    WHERE 1 = 1
      AND r.name = 'PIX_MASTER'
      AND u.email = 'pierre.top@pix.fr'
)
;



