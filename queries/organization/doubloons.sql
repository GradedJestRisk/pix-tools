INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('123456789AB', 'first', 'last', '01-01-2000', NULL, 9)
 ;

INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('123456789AB', 'first', 'last', '01-01-2000', 1, 3)
 ;

INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('123456789AB', 'first', 'last', '01-01-2000', 2, 6)
 ;

INSERT INTO
    "schooling-registrations"
 ("nationalStudentId", "firstName", "lastName", birthdate,  "userId", "organizationId")
 VALUES
 ('123456789AB', 'first', 'last', '01-01-2000', 2, 7)
 ;


SELECT
--        sr.id,
        sr."nationalStudentId",
        sr."firstName",
        sr."lastName",
        sr."birthdate",
        sr."userId"
        --sr.*
FROM "schooling-registrations" sr
WHERE 1=1
   AND sr."nationalStudentId" =  '123456789AB'
   AND sr."firstName"         =  'first'
   AND sr."lastName"          =  'last'
;

SELECT
    dsu."nationalStudentId",
    dsu."firstName",
    dsu."lastName",
    dsu."birthdate",
    COUNT(1)
-- SELECT *
FROM
    (SELECT DISTINCT
        sr."nationalStudentId",
        sr."firstName",
        sr."lastName",
        sr."birthdate",
        sr."userId"
    FROM
        (
            select count(1), t."nationalStudentId", t."firstName", t."lastName", t."birthdate"
            from ( SELECT * FROM "schooling-registrations" ) t
            GROUP BY t."nationalStudentId", t. "firstName", t."lastName", t."birthdate"
            HAVING count(1) > 1
        ) duplicated_sr
            INNER JOIN "schooling-registrations" sr
                ON     sr."nationalStudentId" = duplicated_sr."nationalStudentId"
                   AND sr."firstName"         = duplicated_sr."firstName"
                   AND sr."lastName"          = duplicated_sr."lastName"
                   AND sr."birthdate"         = duplicated_sr."birthdate"
        WHERE "userId" IS NOT NULL
        ) dsu
--;
GROUP BY
    dsu."nationalStudentId",
    dsu."firstName",
    dsu."lastName",
    dsu."birthdate"
HAVING
    COUNT(1) > 1;

