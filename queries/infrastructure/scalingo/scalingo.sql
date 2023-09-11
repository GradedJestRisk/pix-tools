-- Application
SELECT
    app.name
    ,'scalingo_app=>'
    ,app.*
FROM
    scalingo_app app
WHERE 1=1
    AND app.name = 'pix-api-production'
    AND app.name ILIKE '%production'
;

inspect scalingo;
