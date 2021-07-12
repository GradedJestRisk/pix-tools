--  https://1024pix.atlassian.net/wiki/spaces/DEV/pages/1989967875/2020-11-09+Faire+un+audit+sur+l+activit+Metabase
-- https://ichi.pro/fr/comment-utiliser-les-metadonnees-de-la-metabase-pour-faciliter-la-decouverte-de-donnees-80980446120190


-- Query
SELECT
    q.query_hash,
    q.average_execution_time,
    q.query query_text
FROM query q
WHERE 1=1
    AND q.query LIKE '%native%'
    AND q.query LIKE '%isSupernumerary%'
;

-- Query + execution
SELECT
   e.started_at, e.result_rows, q.query
FROM query q
    INNER JOIN query_execution e ON q.query_hash = e.hash
      -- INNER JOIN metabase_database md on q.db_id = md.id
WHERE 1=1
   AND  q.query like '%numerary%'
   --AND  md.name = 'pix-datawarehouse-externe-production'
;


-- Query execution
SELECT
    qe.id,
    qe.native,
    qe.hash query_hash,
    qe.executor_id,
    qe.database_id,
    qe.started_at,
    qe.running_time,
    qe.result_rows,
    qe.error
FROM
     query_execution qe
 WHERE 1=1
    --database_id = 11
   AND started_at BETWEEN current_timestamp - interval '1 day' AND current_timestamp
   AND qe.error IS NOT NULL
;



-- Query + execution + user
-- Given a user
SELECT
       q.query, q.*
  FROM query q
    INNER JOIN query_execution e on q.query_hash = e.hash
    INNER JOIN core_user u on u.id = e.executor_id
WHERE 1=1
    AND e.database_id = 11
    AND u.id in (47, 123, 138, 190)
;


-- Query + execution + user + database
-- Given a database, all in error
SELECT
   q.query,
   TO_CHAR(qe.started_at,'DD/MM/YYYY'),
   qe.native,
---   db.name,
   u.email,
   qe.error,
   qe.card_id,
   qe.context
  -- ,qe.*
FROM query q
    INNER JOIN query_execution qe on q.query_hash = qe.hash
    INNER JOIN metabase_database db ON db.id = qe.database_id
    INNER JOIN core_user u on u.id = qe.executor_id
WHERE 1=1
   AND db.name = 'pix-production-live'
--   AND db.name = 'pix-datawarehouse-production'
--   AND db.name = 'pix-datawarehouse-externe-production'
--   AND started_at BETWEEN current_timestamp - interval '2 day' AND current_timestamp
   AND u.email = 'antoine.leblanc@pix.fr'
   AND qe.error   IS NOT NULL
--   AND qe.native  IS TRUE
--     AND qe.error   NOT IN ('ERROR: canceling statement due to user request',
--                           'Erreur lors de la réduction des lignes de résultats',
--                           'Erreur lors de la création de la carte des paramètres de requête',
--                           'ERROR: division by zero')
   AND qe.error   LIKE 'ERROR: column "isSupernumerary" does not exist%'
;



-- Query + execution + user
-- Given a query text
SELECT
   q.query,
   db.name,
   u.*
FROM query q
    INNER JOIN query_execution e on q.query_hash = e.hash
    INNER JOIN metabase_database db ON db.id = e.database_id
    INNER JOIN core_user u on u.id = e.executor_id
WHERE 1=1
    AND db.name = 'pix-datawarehouse-production'
    AND q.query LIKE '%native%'
    AND q.query LIKE '%isSupernumerary%'
;


-- Query type
select distinct context
  from query_execution
 where database_id = 11;
-- ad-hoc
-- csv-download
-- question
-- xlsx-download


-- Table accessed
select id, name from metabase_table where id in (492, 493, 496, 499)

select u.id, e.started_at, e.result_rows, q.query
  from query q
  join query_execution e on q.query_hash = e.hash
  join core_user u on u.id = e.executor_id
 where e.database_id = 11 and u.id in (47, 123, 138, 190) and q.query like '%source-table":453%'

-- Data download
select u.id, e.context, e.started_at, q.query
  from query q
  join query_execution e on q.query_hash = e.hash
  join core_user u on u.id = e.executor_id
 where e.database_id = 11 and u.id in (47, 123, 138, 190) and e.context = 'xlsx-download'

-- Carte
select * from report_card
where name = 'Evolution des participations'
;

-- Carte
SELECT
   rc.id,
   rc.name,
   rc.query_type,
   rc.*
FROM
   report_card rc
WHERE 1=1
    AND rc.id         =   2194
    AND rc.query_type =   'native'
    AND rc.name = 'Information étudiants SUP'
;