with all_versions_by_software as (
  select
    attributes ->> 'software' as software,
    array_agg(attributes) as attributes
  from
    datadog_log_event
  where
    query = '@type:software_version'
    and timestamp >= (current_date - interval '1' day)
  group by
    attributes ->> 'software'
), last_version as (
  select
    software,
    (select * from (select unnest(attributes) as attributes) as sub order by (attributes -> 'syslog' ->> 'timestamp')::timestamp desc limit 1)
  from
    all_versions_by_software
)
select
  software as "Application",
  case attributes ->> 'version' = attributes ->> 'available_version'
    WHEN true THEN 'oui' ELSE 'non' END as "A jour",
  attributes ->> 'version' as "Version déployée",
  attributes ->> 'available_version' as "Version disponible",
  TO_CHAR((attributes -> 'syslog' ->> 'timestamp'):: TIMESTAMP,'DD/MM/YYYY HH24:mm') as "Date de dernière vérification"
from
  last_version
