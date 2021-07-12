--  https://1024pix.atlassian.net/wiki/spaces/DEV/pages/1989967875/2020-11-09+Faire+un+audit+sur+l+activit+Metabase
-- https://ichi.pro/fr/comment-utiliser-les-metadonnees-de-la-metabase-pour-faciliter-la-decouverte-de-donnees-80980446120190

-- Database
select
   db.id,
   db.name,
   db.created_at,
   db.*
from metabase_database db
;
