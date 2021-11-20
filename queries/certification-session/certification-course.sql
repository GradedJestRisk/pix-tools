


SELECT
*
FROM "certification-courses"
;

SELECT
*
FROM "certification-issue-reports"
;

select * from "schooling-registrations" sr
WHERE 1=1
    AND sr."userId" = 104924
;

SELECT
*
FROM "certification-challenges"
;

SELECT
*
FROM "certification-cpf-cities"
;


---
UPDATE sessions
SET "supervisorPassword" = 'PIX12'
WHERE "supervisorPassword" IS NOT NULL;