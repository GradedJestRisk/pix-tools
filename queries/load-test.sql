DROP TABLE IF EXISTS test_executions;
CREATE TABLE test_executions (id SERIAL PRIMARY KEY, api_version VARCHAR NOT NULL, started_at TIMESTAMP DEFAULT NOW(), ended_at TIMESTAMP, report JSONB);

SELECT
       id,
       started_at, ended_at, ( ended_at - started_at) AS duration
FROM test_executions
ORDER BY ended_at DESC
LIMIT 5;

SELECT
    data
FROM test_reports
LIMIT 1;
WHERE id=1;


SELECT
    report->'aggregate'->'timestamp'                  AS executed_at,
    report->'aggregate'->'scenarioDuration'->'median' AS median_duration_millis
FROM test_executions
ORDER BY ended_at DESC
LIMIT 5;

WHERE id=1;

TRUNCATE test_executions;