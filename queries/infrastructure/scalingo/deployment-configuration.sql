-- Link between Github user account and Scalingo user account
SELECT
  'integration=>'
  ,ssi.username    github_username
  ,ssi.uid
  ,ssi.
  ,'scalingo_scm_integration=>'
  ,ssi.*
FROM scalingo_scm_integration ssi
WHERE 1=1
  AND ssi.username = 'pix-service'
;

-- Link between Scalingo application and Github repository
SELECT
  'application=>'
  ,app.name
  ,app.region
  ,'repo-link=>'
  ,srl.scm_type
  ,srl.url || '/' || srl.owner ||  '/' || srl.repo
  ,srl.auto_deploy_enabled
  ,srl.branch
  ,srl.auth_integration_uuid
  ,'scalingo_scm_repo_link=>'
  ,srl.*
FROM scalingo_app app
  INNER JOIN scalingo_scm_repo_link srl ON srl.app_id = app.id
WHERE 1=1
  AND app.name = 'pix-api-integration'
  --AND app.owner_username = 'pix-dev'
  --AND srl.auth_integration_uuid = '9fbadb5c-eec9-11eb-8a12-0242ac110078'
;


