-- Mission = thématique
--

-- Pour une activité, combien on a eu de réponses ?

-- Besoin = quelle est la prochaine épreuve à donner ?
-- Réponse :
-- * la courante si jamais répondu
-- * si déjà répondu, nouvelle activité ou autre épreuve de l'activité


 assessment ( copie : Q + R / évaluation)

-- mission = N activité 4 niveaux passable plusieurs fois par parcours
-- activité = N épreuves

-- activities = activity-assessment
-- asssessment.mission
-- answers.challengeId ( =>


-- Activity
SELECT
--  ctv.id,
--  ctv.level,
--  ctv."assessmentId",
  ctv.*
FROM activities ctv
WHERE 1=1
--    AND a."assessmentId" = 13003
ORDER BY id DESC
;

INSERT INTO activities
  ( id, "assessmentId", level, "createdAt")
VALUES
  ( 2,  104417 , 'LEVEL', NOW())
;


-- Activity + Assessment
SELECT
    'activity=>',
    ctv.id,
    ctv.level,
    ctv."assessmentId",
    'assessment=>',
    ass.id,
    ass."lastQuestionState",
    ass."lastChallengeId",
    ass."lastQuestionDate"
FROM activities ctv
         INNER JOIN assessments ass ON ass.id = ctv."assessmentId"
WHERE 1 = 1
   -- AND ctv.id = 2
   AND ass.id = 104417
;



-- Activity + Assessment + Answer
SELECT
    'activity=>',
    ctv.id,
    ctv.level,
    ctv."assessmentId",
    'assessment=>',
    ass.id,
    ass."lastQuestionState",
    ass."lastChallengeId",
    ass."lastQuestionDate",
    'answer=>',
    ans.id,
    ans."createdAt" "answeredAt",
    ans."challengeId",
    ans.value,
    ans.result,
    ans."isFocusedOut"
    --,'answers=>'
    -- ,ans.*
FROM activities ctv
        INNER JOIN assessments ass ON ass.id = ctv."assessmentId"
          INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
   -- AND ctv.id = 2
ORDER BY ans."createdAt" DESC
LIMIT 5
;
