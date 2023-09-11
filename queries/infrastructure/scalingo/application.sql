SELECT
  'application=>'
  ,app.name
  ,app.region
  ,app.owner_username
  ,app.url application_url
  ,app.git_url repository_url
  ,'scalingo_app=>'
  ,app.*
FROM scalingo_app app
WHERE 1=1
  AND app.name = 'pix-api-integration'
  AND app.owner_username = 'pix-dev'
;
