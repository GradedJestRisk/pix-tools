
-- Addons
SELECT
    add.id
    ,add.app_name
    ,add.provider_id
    ,add.plan_display_name
    ,add.status
    ,'scalingo_addons=>'
    ,add.*
FROM
    scalingo_addon add
WHERE 1=1
    AND add.app_name = 'pix-api-production'
    AND add.provider_id = 'postgresql'
;


-- App + Addon
SELECT
    add.id
    ,add.app_name
    ,add.provider_id
    ,add.plan_display_name
    ,add.status
    ,'scalingo_addons=>'
    ,add.*
FROM
    scalingo_app app
        INNER JOIN scalingo_addon add ON add.app_name = app.name
WHERE 1=1
--    AND add.app_name = 'pix-api-production'
    AND app.name ILIKE '%production'
    AND add.provider_id = 'postgresql'
;

