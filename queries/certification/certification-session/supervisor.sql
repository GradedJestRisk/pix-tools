-- Supervisor
SELECT *
FROM
"supervisor-accesses" sup
WHERE 1=1
;


DELETE
FROM "supervisor-accesses" sup
WHERE 1=1
    AND "userId" = 102
    AND "sessionId" = 11
;

INSERT INTO  "supervisor-accesses"
()
VALUES
();

-- Activation
SELECT name
FROM "certification-centers" cc
WHERE 1=1
    AND cc.id =
--    AND cc."isSupervisorAccessEnabled" IS TRUE
;

UPDATE "certification-centers" cc
SET cc."isSupervisorAccessEnabled" = TRUE
WHERE 1=1
    AND cc."name" =
    AND cc."isSupervisorAccessEnabled" IS FALSE
;