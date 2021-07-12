select id, count(1)
from challenges
group by id having count(1) > 1;


SELECT * FROM challenges c
WHERE 1=1
AND EXISTS
    (select id, count(1)
    from challenges c_dbl
    where c_dbl.id = c.id
    group by id having count(1) > 1)
ORDER BY
    c.id;


SELECT *
FROM
    challenges c
WHERE 1=1
    AND c.id = 'rec12UFLhPu2fyXnH'
;

SELECT
       c.id challenge_id,
       substring(c.instructions FROM 0 for 10),
       s.id skill_id,
       s.name,
       t.id tube_id,
       t.name,
       cm.id competence_id,
       substring(cm.name FROM 0 for 10),
       a.id area_id,
       a.name
FROM
    challenges  c,
    skills      s,
    tubes       t,
    competences cm,
    areas       a
WHERE 1=1
    AND c.id  = 'rec12UFLhPu2fyXnH'
    AND s.id  = c."firstSkillId"
    AND t.id  = s."tubeId"
    AND cm.id = t."competenceId"
    AND a.id  = cm."areaId"
;


SELECT *
FROM skills
;

SELECT *
FROM tubes
;

SELECT *
FROM competences
;

SELECT *
FROM areas
;