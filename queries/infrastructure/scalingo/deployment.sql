-- Deployment
SELECT
  'deployment=>'
  ,sd.id
  ,sd.status
  ,sd.duration
  ,sd.created_at
  ,'scalingo_deployment=>'
  ,sd.*
FROM scalingo_deployment sd
WHERE 1=1
  AND sd.app_name = 'pix-api-integration'
--  AND DATE_PART('Year', sd.created_at) = '2023'
--  AND DATE_PART('Month', sd.created_at) = '01'
--  AND DATE_PART('Day', sd.created_at) = '26'
--ORDER BY sd.created_at DESC
;
