-- Authentication method
-- all
SELECT
    am."identityProvider"
    ,am."externalIdentifier"
    ,am.*
FROM
     "authentication-methods" am
WHERE 1=1
    AND am."userId" = 106013
  --  AND am."identityProvider" = 'POLE_EMPLOI'
--     AND u.id =
;

-- Authentication method: PIX, GAR, PE ?
-- all
SELECT
    am."identityProvider",
    COUNT(1)
FROM
     "authentication-methods" am
GROUP BY
    am."identityProvider"
;

-- User + Authentication method
-- all
SELECT
    'user=>'
    ,u.id
    ,u."firstName"
    ,u."lastName"
    ,u.username
    ,u.email
    ,'authentication=>'
    ,am.id
    ,am."userId"
    ,am."identityProvider"
    ,am."externalIdentifier"
    ,am."authenticationComplement"
--    am.*
FROM
     users   u
        INNER JOIN "authentication-methods" am ON am."userId" = u.id
WHERE 1=1
    --AND u."firstName" = 'BALKINE'
    --AND am."identityProvider" = 'PIX'
    AND u.email = 'billy.thekid106013@example.net'
;




-- User + Internal authentication method
-- all
SELECT
    'user=>'
    ,u.id
    ,u."firstName"
    ,u."lastName"
    ,u.username
    ,u.email
    ,'authentication=>'
    --,am.id
    --,am."userId"
    --,am."authenticationComplement"
    ,jsonb_pretty(am."authenticationComplement")
--    am.*
FROM
     users   u
     INNER JOIN "authentication-methods" am ON am."userId" = u.id
WHERE 1=1
    --AND u.email = 'pixmaster@example.net'
    AND am."identityProvider" = 'PIX'
--    AND am."authenticationComplement"->'shouldChangePassword' = 'false'
;




-- User + External authentication method
-- all
SELECT
    'user=>'
    ,u.id
    ,u."firstName"
    ,u."lastName"
    ,u.username
    ,u.email
    ,'authentication=>'
     ,am.id
--     ,am."userId"
    ,am."identityProvider"
    ,am."externalIdentifier"
    ,am."authenticationComplement"
--    am.*
FROM
     users   u
     INNER JOIN "authentication-methods" am ON am."userId" = u.id
WHERE 1=1
    AND u."firstName" = 'BALKINE'
--    AND u.email = 'pixmaster@example.net'
    AND am."identityProvider" = 'POLE_EMPLOI'
--     AND am."externalIdentifier" = '7e93e516c92be18a4303b4d58f8a854ac84807ea65731db3e057ece6ecb9e4b4ac98513edf09c018104d694dccb1599b64722ea2240b9784f187565390a5cf32'
;

-- Force password change
UPDATE
     "authentication-methods"
SET
    "authenticationComplement" = jsonb_set("authenticationComplement", '{shouldChangePassword}', '"true"')
WHERE 1=1
    AND "userId" IN (SELECT id
                    FROM users u WHERE 1=1
--                       AND u.email = 'sylvain@example.net'
                       AND u.username = 'sylvain.barbier2503'
        )
;

-- Remove password change
UPDATE
     "authentication-methods"
SET
    "authenticationComplement" = jsonb_set("authenticationComplement", '{shouldChangePassword}', '"false"')
WHERE 1=1
    AND "userId" IN (SELECT id FROM users u WHERE u.email = 'sylvain@example.net')
;


-- Update password to pix123
UPDATE
     "authentication-methods"
SET
    "authenticationComplement" = jsonb_set("authenticationComplement", '{password}',
        '"$2a$05$IP2HpgRg180EVjTnnq5yTOAW.42Bt3dIxoRMu6lV1NYHTSJeXO.U."' -- pix123
     --   '"$2b$05$i.HG3bXkvM7PvDJImDnDS.4eeb6matv.CP5./RKFc5it5t36jduuq"' -- Azerty123* ??
    )
WHERE 1=1
    AND "userId" IN (SELECT id
                    FROM users u WHERE 1=1
--                       AND u.email = 'sylvain@example.net'
                       AND u.username = 'sylvain.barbier2503'
        )
;

-- Remove external authentication
DELETE FROM
     "authentication-methods"
WHERE 1=1
    AND  id = 22977
    AND "identityProvider" IN ('POLE_EMPLOI')
;



-- Remove internal authentication
DELETE FROM
   "authentication-methods" am
WHERE 1=1
    AND "userId" IN (SELECT id FROM users u WHERE u.email = 'pixmaster@example.net')
    AND "identityProvider" = 'PIX'
;


-- Remove external authentication
UPDATE
     "authentication-methods"
SET
    "externalIdentifier" = NULL
WHERE 1=1
    AND "userId" = 1
    AND "identityProvider" IN ('GAR', 'PE')
    AND "externalIdentifier" IS NOT NULL
;

