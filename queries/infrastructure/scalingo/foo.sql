with apps_and_addons as (
  select
    ad.id as id,
    ad.app_name as app_name
  from
    scalingo_osc.scalingo_app app
  join
    scalingo_addon ad
  on
    ad.app_name = app.name
   where app.name = 'pix-api-integration'
)
select
  db.app_name as "Nom de l'application",
  db.type_name as "Type de la base",
  db.readable_version as "Version",
from
  scalingo_osc.scalingo_database db
join
  apps_and_addons ad
on
  ad.id = db.addon_id and ad.app_name = db.app_name
