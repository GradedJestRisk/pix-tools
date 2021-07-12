--  https://1024pix.atlassian.net/wiki/spaces/DEV/pages/1989967875/2020-11-09+Faire+un+audit+sur+l+activit+Metabase
-- https://ichi.pro/fr/comment-utiliser-les-metadonnees-de-la-metabase-pour-faciliter-la-decouverte-de-donnees-80980446120190


select
   tbl.id
  ,tbl.name
  ,tbl.db_id db_id
--,tbl.*
from metabase_table tbl
ORDER BY tbl.name
;

-- Table + database
SELECT
   tbl.id
  ,tbl.name
  ,tbl.db_id db_id
--,tbl.*
FROM
     metabase_table tbl
         INNER JOIN metabase_database md on tbl.db_id = md.id
WHERE 1=1
   AND  md.name = 'pix-datawarehouse-externe-production'
   AND tbl.name = 'knowledge-element-snapshots'
ORDER BY tbl.name
;
;