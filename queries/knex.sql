SELECT *
    FROM "knex_migrations" m
WHERE 1=1
--    AND m.batch = 1
    AND m.name = '20220406083222_add_index_for_table_knowledge_elements_on_column_assessmentId.js'
ORDER BY m.migration_time DESC
;

SELECT *
FROM knex_migrations_lock
;

