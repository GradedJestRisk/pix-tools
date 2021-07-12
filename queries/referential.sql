CREATE TABLE referentiel (
  rownum SERIAL PRIMARY KEY,
  skill_id 		VARCHAR,
  tube_id 		VARCHAR,
  competence_id VARCHAR,
  pix_value 	NUMERIC(6,5),
  level			INTEGER
);


SELECT char_length(id) FROM skills;

SELECT * FROM tubes;

SELECT * FROM competences;


SELECT * FROM skills;

SELECT * FROM tubes;

SELECT
   s."id"        "skill_id",
   t."id"        "tube_id",
   c."id"        "competence_id",
   s."pixValue"  "pix_value",
   s."level"     "level"
FROM
     skills s
         INNER JOIN tubes t ON s."tubeId" = t.id
         INNER JOIN competences c ON t."competenceId" = c.id
;