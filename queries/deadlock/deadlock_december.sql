-- A eu lieu

-- A venir: niveau 6

-- ADD COLUMN certification-courses.maxReachableLevelOnCertificationDate
-- PIX-1781 / https://github.com/1024pix/pix/pull/2276/files
-- api/db/migrations/20201215145328_add-column-max-reachable-level-certification-course.js
-- 2020 12 15 1453 28_add
-- const TABLE_NAME = 'certification-courses';
-- const COLUMN_NAME = 'maxReachableLevelOnCertificationDate';
--
-- exports.up = async (knex) => {
--   return knex.schema.table(TABLE_NAME, (table) => {
--     table.integer(COLUMN_NAME).notNullable().defaultTo(5);
--   });
-- };

SELECT
    cc.id,
    cc."maxReachableLevelOnCertificationDate"
--  ,cc.id
FROM "certification-courses" cc
WHERE 1=1
--    AND cc
;

-- ADD COLUMN users.hasSeenNewLevelInfo
-- PIX-1793 / https://github.com/1024pix/pix/pull/2291
-- api/db/migrations/20201215163843_add_column_has-seen-new-level-info_to_users.js
-- 2020 12 15 16 38
-- const TABLE_NAME = 'users';
-- const COLUMN_NAME = 'hasSeenNewLevelInfo';
--
-- exports.up = function(knex) {
--   return knex.schema.table(TABLE_NAME, (table) => {
--     table.boolean(COLUMN_NAME).defaultTo(false);
--   });
-- };


SELECT
 u.id,
 u."hasSeenNewLevelInfo"
--,u.*
FROM users u
;


SELECT
  'migration:'
  ,mgr.id
  ,mgr.name            filename
  ,mgr.migration_time  executed_at
  ,'knex_migrations=>'
  ,mgr.*
FROM knex_migrations mgr
WHERE 1=1
ORDER BY
    mgr.migration_time DESC
;

-- Ordre d'exécution
-- 235, '20201215145328_add-column-max-reachable-level-certification-course.js   => certification-courses
-- 236, '20201215163843_add_column_has-seen-new-level-info_to_users.js           => users


[alter certification-courses] and [alter users] are in the same transaction

Sequence
[ alter certification-courses ] has been submitted and executed
    => creating an AccessExclusive lock on certification-courses, waiting for transaction validation (COMMIT) to release it
[ select certification-courses, users ] has been submitted
    => created an AccessShareLock on users
    => waiting for AccessShareLock on certification-courses to be granted (which will be granted once AccessExclusive is released, when transaction is validated )
[ alter users ] has been submitted
    => waiting for AccessExclusive lock on users to be granted (which will be granted once AccessShareLock is released, when transaction is validated )

But transaction encompass [ alter certification-courses ] and [ alter users ], so [ alter users ] will never succeed
So [ alter certification-courses ] will be rollbacked, but front-end will still consider te new colmun is available