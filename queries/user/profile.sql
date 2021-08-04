

-- profile
-- all
SELECT
    COUNT(1)
FROM users u
WHERE 1=1
--     AND u.id = 220610
;


-- profile
-- All
SELECT
    u.id
    ,u."firstName"
    ,u."lastName"
    ,u.email
    ,u.username
    ,u."emailConfirmedAt"
    ,u."lastTermsOfServiceValidatedAt"
    ,'users=>'
    ,u.*
FROM users u
WHERE 1=1
--     AND u.id = 221573
--    AND u.email LIKE 'geo%@example.net'
    AND u."emailConfirmedAt" IS NOT NULL
ORDER BY
   --u."lastName" ASC
   u."createdAt" DESC
;

-- profile
-- Given username
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.username ,
    u.email
--    u.*
FROM users u
WHERE 1=1
     --AND u.id = 100036
    AND u.username ILIKE '%mor%'
ORDER BY u.username ASC
;


-- profile
-- Given firstname
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.username ,
    u.email
--    u.*
FROM users u
WHERE 1=1
     --AND u.id = 100036
    AND u."firstName" ILIKE '%lya%'
ORDER BY u.username ASC
;


-- profile
-- Given email
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u.password,
    u."samlId"
--    u.*
FROM users u
WHERE 1=1
--     AND u.id = 220610
    --AND u.email LIKE '%@example.net'
    AND u.email IN (
        'leo.jacquemin@pix.fr',
        'abdelmalek.ouarab@pix.fr',
        'elise.dartois@pix.fr')
    --AND u.email LIKE '%jau%'
ORDER BY u.email ASC
;

--
SELECT
    u.email, COUNT(1)
FROM users u
WHERE u.email IS NOT NULL
GROUP BY u.email
HAVING COUNT(1) > 1
;




-- profile
-- With SAML authentication method
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u.username,
    u."samlId"
--    u.*
FROM users u
WHERE 1=1
--     AND u.id = 220610
  AND u."samlId" IS NOT NULL
;


-- profile
-- Given name
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.username ,
    u.email,
    u."samlId"
--    u.*
FROM users u
WHERE 1=1
--     AND u.id = 220610
--    AND u."firstName" LIKE 'em%'
    AND u."firstName" = 'CECILE'
ORDER BY u.username ASC
;


-- profile
-- Given ..
SELECT
    u.id,
    u."firstName",
    u."lastName",
    u.email,
    u.username,
    u."samlId"
--    u.*
FROM users u
WHERE 1=1
--     AND u.id = 220610
    AND ( u.email = 'mormont.lyanna@example.net' OR u.username = 'lyanna.mormont0701')
;


-- profile
-- with is password not null ????
SELECT *
FROM users
WHERE 1=1
  AND "samlId" IS NOT NULL
  AND username IS NULL
  AND email    IS NULL
  AND password IS NOT NULL
;


-- Change name
UPDATE users
    SET "firstName" = 'John', "lastName"='Doe'
WHERE id = 100033
;

-- Change email
UPDATE users
    --SET email = 'pierre.top+integration@pix.fr'
    SET email = 'sylvain.barbier@example.net'
WHERE 1=1
--  AND email = '1024pix.dev@gmail.com'
  AND username = 'sylvain.barbier2503'
RETURNING *
;


-- Remove user
DELETE FROM users
WHERE 1=1
  AND id = 221619
RETURNING *
;


-- Create user with password
INSERT INTO users ( "firstName", "lastName", password)
VALUES ('John', 'Doe', 'f4z5zqcf5e51');


INSERT INTO users ( id, "firstName", "lastName", password)
VALUES (-1, 'John', 'Doe', 'f4z5zqcf5e51');

SELECT * FROM users WHERE id =-1;

INSERT INTO users ( "firstName", "lastName", password)
SELECT  "firstName" || ' junior', "lastName", password
FROM users WHERE password IS NOT NULL
RETURNING *
;

-- Create user with samlId
INSERT INTO users ( "firstName", "lastName", "samlId", password)
VALUES ('John', 'Foo', '445554', 'f4z5zqcf5e51');

SELECT "samlId" FROM users WHERE "samlId" IS NOT NULL;

