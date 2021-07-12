--  https://1024pix.atlassian.net/wiki/spaces/DEV/pages/1989967875/2020-11-09+Faire+un+audit+sur+l+activit+Metabase
-- https://ichi.pro/fr/comment-utiliser-les-metadonnees-de-la-metabase-pour-faciliter-la-decouverte-de-donnees-80980446120190


--Le champs executor_id pointe sur la table core_user, qui permet d’avoir plus d’informations sur la personne qui a accédé aux données.
select id, email
  from core_user
 where id in (6, 47 ,123, 138, 146, 190)
;

