SELECT *
FROM answers a
WHERE 1=1
--    AND a."assessmentId" = 13003
;

-- User + Assessment + Answer
SELECT
    'user=>',
    u."firstName",
    u."lastName",
    u.email,
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
FROM users u
         INNER JOIN assessments ass ON ass."userId" = u.id
         INNER JOIN answers ans on ans."assessmentId" = ass.id
WHERE 1 = 1
    AND u.email = 'certif1@example.net'
  -- AND ans.result <> 'ok'
  --  AND ans.value <> '#ABAND#'
--   AND ans."createdAt" BETWEEN '2022-02-11 11:00:00.000000 +00:00' AND '2022-02-11 18:00:00.000000 +00:00'
--   AND ans."challengeId" IN ('rec6m0IwAPju8VhXr', 'recC9Bgcmus1udujY')
ORDER BY ans."createdAt" DESC
LIMIT 5
;
