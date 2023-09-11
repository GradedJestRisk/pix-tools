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
  (
    select
      case
        when next_upgrade_id is not null then concat(next_upgrade_major, '.', next_upgrade_minor, '.', next_upgrade_patch)
        else ''
      end
    from
       scalingo_osc.scalingo_database_type_version
    where
       id = db.version_id
       and addon_id = db.addon_id
       and app_name = db.app_name
    limit
      1
  ) as "Version disponible"
from
  scalingo_database db
join
  apps_and_addons ad
on
  ad.id = db.addon_id and ad.app_name = db.app_name
