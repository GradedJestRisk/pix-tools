-- Assesment
SELECT
     ssm.id          ssm_dtf
    ,ssm."courseId"  crs_dtf
    ,ssm.type
    ,ssm.state
    ,'assessments=>'
    ,ssm.*
FROM assessments ssm
WHERE 1=1
    AND ssm.id = 10000000
;

-- Referential
select
       id,
       name
from courses c
where c.id = 'rec7UnJAHSEP3iwi2';
/*      id         |     name     | adaptive | competenceId
-------------------+--------------+----------+--------------
 rec7UnJAHSEP3iwi2 | Test de démo | f        |
(1 row)*/
