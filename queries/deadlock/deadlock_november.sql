En regardant de plus près avec @Pierre (TOPI) et @Mathieu hier on a identifié une cause plus précise du deadlock rencontré vendredi.
Comme bien documenté par @youness.yahya la requête de modification de la structure de users a tenté d’acquérir un verrou exclusif sur cette table.
En soi ce n’est pas un problème, même si un tas d’autres requêtes veulent un verrou sur cette table PG est tout à fait capable de mettre notre migration en file d’attente:
dès que le processus détenant un verrou se termine, la migration peut s’exécuter et pendant qu’elle s’exécute les autres demandes sont mises en pause.
Le problème c’est que le détenteur du verrou sur users (la requête Pix Orga) ne pouvait pas se terminer parce qu’il attendait lui-même d’obtenir
un verrou sur une autre table (138183 = schooling-registrations) avant de relâcher le verrou sur users.
Et le détenteur de ce verrou sur schooling-registrations n’est autre que… le processus qui fait la migration ! D’où le deadlock.

Mais pourquoi donc cette migration prend-elle un verrou sur schooling-registrations, alors que son contenu est :
const TABLE_NAME = 'users';
const COLUMN_NAME = 'lang';
exports.up = function(knex) {
  return knex.schema.table(TABLE_NAME, async (table) => {
    table.string(COLUMN_NAME).notNullable().defaultTo('fr');
  });
}
;
?
La cause en est l’autre migration embarquée dans cette release,
à savoir 20201106093514_add_unicity_contraint_schooling_registration_on_apprenticeId_and_organizationId dont le contenu est :

const TABLE_NAME = 'schooling-registrations';
exports.up = function(knex) {
  return knex.schema.table(TABLE_NAME, (table) => {
    table.unique(['organizationId','nationalApprenticeId']);
  });
};
Or :
• knex exécute l’intégralité des migrations nécessaires lors d’un déploiement dans une unique transaction (c’est nécessaire pour éviter de se retrouver avec la base dans un état ne correspondant à aucune release) ;
• les verrous acquis par une requête s’exécutant au sein d’une transaction ne sont libérés qu’à la fin de la transaction (COMMIT ou ROLLBACK).
En conclusion, et ça fera plaisir à @Jérémy, la “vraie” cause de l’échec de vendredi c’est que la release 2.220.0 était trop grosse…


-- https://github.com/1024pix/pix/compare/v2.219.0...v2.220.0

api/db/migrations/20201106093514_add_unicity_contraint_schooling_registration_on_apprenticeId_and_organizationId.js
const TABLE_NAME = 'schooling-registrations';

exports.up = function(knex) {
  return knex.schema.table(TABLE_NAME, (table) => {
    table.unique(['organizationId','nationalApprenticeId']);
  });
};

--
-- api/db/migrations/20201106114017_add-lang-column-for-user.js
const TABLE_NAME = 'users';
const COLUMN_NAME = 'lang';

exports.up = function(knex) {
  return knex.schema.table(TABLE_NAME, async (table) => {
    table.string(COLUMN_NAME).notNullable().defaultTo('fr');
  });
};
--
-- exports.down = function(knex) {
--   return knex.schema.table(TABLE_NAME, (table) => {
--     table.dropColumn(COLUMN_NAME);
--   });
-- };



--
-- 138 183 schooling-registrations
-- 30 074   users


[LOG] 2020-11-20 12:03:55.383652642 +0100 CET [postdeploy-6042] error: alter table “users” add column “lang” varchar(255) not null default ‘fr’ - deadlock detected
[LOG] 2020-11-20 12:03:55.383625427 +0100 CET [postdeploy-6042] Process 7304 waits for AccessShareLock on relation 138183 of database 16401; blocked by process 7242.
[LOG] 2020-11-20 12:03:55.383619711 +0100 CET [postdeploy-6042] Process 7242 waits for AccessExclusiveLock on relation 30074 of database 16401; blocked by process 7304

Process 7242: alter table “users” add column “lang” varchar(255) not null default ‘fr’
Process 7304: select from users inner join  schooling-registrations

with “campaign_participation_summaries” as (
    .join('users', 'users.id', 'campaign-participations.userId')
    .leftJoin('schooling-registrations', function() {

function _campaignParticipationByParticipantSortedByDate(qb, campaignId) {

SELECT
   oid     obj_dtf ,
   relname tbl_nm
FROM
     pg_class
WHERE 1=1
--    AND relname = 'users'
    AND relkind = 'r'
    AND oid     IN ( 138183, 30074)
ORDER BY
    relname ASC
;
-- 138 183 schooling-registrations
-- 30 074   users


Process 7304 ( select from users, schooling-registration ) waits for AccessShareLock on schooling-registrations; blocked by process 7242 ( alter table users add column “lang” ).
Process 7242 ( alter table users add column “lang” )       waits for AccessExclusiveLock on users;               blocked by process 7304 ( select from users, schooling-registration )

[ alter table users add column “lang”]       needs AccessExclusiveLock on users,                   but another query has a AccessShareLock
[ select from users, schooling-registration] needs AccessShareLock     on schooling-registrations, but another query has a AccessExclusiveLock
[ alter table schooling-registrations]       needs AccessExclusiveLock on schooling-registrations, but another query has a AccessShareLock

[alter users] WAITS FOR [select from users, schooling-registration] WAITS FOR [ alter schooling-registration]
BUT [alter users] and [ alter schooling-registration] are in the same transaction (knex)
SO as long as [select keeps waiting], migrations will keep waiting, which is a deadlock