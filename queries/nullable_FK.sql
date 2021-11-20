
SELECT
--     tc.constraint_name,
--     tc.table_name    AS referencing_table_name,
--     kcu.column_name  AS referencing_column_name,
--     c.is_nullable,
--     ccu.table_name   AS referenced_table_name,
--     ccu.column_name  AS referenced_column_name,
    'SELECT id FROM  "' ||  tc.table_name || '" WHERE "' || kcu.column_name ||'" IS NULL LIMIT 1;' AS check
FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN  information_schema.columns c
        ON  c.table_name = tc.table_name
        AND c.column_name = kcu.column_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE 1=1
  AND tc.constraint_type = 'FOREIGN KEY'
  AND c.is_nullable   = 'YES'
--  AND tc.table_name       IN ('answers', 'feedbacks')
--     AND tc.table_name   = 'authentication-methods'
--     AND ccu.table_name  = 'users'
ORDER BY
   tc.table_name,
   kcu.column_name
;




SELECT * FROM  "account-recovery-demands" WHERE "schoolingRegistrationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "answers" WHERE "assessmentId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "assessment-results" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "assessment-results" WHERE "juryId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "certificationCourseId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "authentication-methods" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "badge-acquisitions" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "badge-criteria" WHERE "badgeId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "badge-partner-competences" WHERE "badgeId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "badges" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "campaign-participations" WHERE "campaignId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "campaign-participations" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "campaigns" WHERE "creatorId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "campaigns" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "certification-candidates" WHERE "schoolingRegistrationId" IS NULL LIMIT 1;
SELECT * FROM  "certification-candidates" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-center-memberships" WHERE "certificationCenterId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "certification-center-memberships" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "certification-challenges" WHERE "courseId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "certification-courses" WHERE "sessionId" IS NULL LIMIT 1;
SELECT * FROM  "certification-courses" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-issue-reports" WHERE "certificationCourseId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "competence-evaluations" WHERE "assessmentId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "competence-evaluations" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "feedbacks" WHERE "assessmentId" IS NULL LIMIT 1; -- 0 rows
--  SELECT * FROM  "knowledge-elements" WHERE "answerId" IS NULL LIMIT 1;
--  SELECT * FROM  "knowledge-elements" WHERE "assessmentId" IS NULL LIMIT 1;
--  SELECT * FROM  "knowledge-elements" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "organizationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "memberships" WHERE "updatedByUserId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "organization-invitations" WHERE "organizationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "organization-tags" WHERE "organizationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "organization-tags" WHERE "tagId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "pole-emploi-sendings" WHERE "campaignParticipationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "schooling-registrations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "sessions" WHERE "assignedCertificationOfficerId" IS NULL LIMIT 1;
SELECT * FROM  "sessions" WHERE "certificationCenterId" IS NULL LIMIT 1;
SELECT * FROM  "target-profile-shares" WHERE "organizationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "target-profile-shares" WHERE "targetProfileId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "target-profiles" WHERE "ownerOrganizationId" IS NULL LIMIT 1;
SELECT * FROM  "target-profiles_skills" WHERE "targetProfileId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "user-orga-settings" WHERE "currentOrganizationId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "user-orga-settings" WHERE "userId" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "users_pix_roles" WHERE "pix_role_id" IS NULL LIMIT 1; -- 0 rows
SELECT * FROM  "users_pix_roles" WHERE "user_id" IS NULL LIMIT 1; -- 0 rows



pix_datawar_7855=> SELECT * FROM  "account-recovery-demands" WHERE "schoolingRegistrationId" IS NULL LIMIT 1;
;
 id | userId | oldEmail | newEmail | temporaryKey | used | createdAt | updatedAt | schoolingRegistrationId
----+--------+----------+----------+--------------+------+-----------+-----------+-------------------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "answers" WHERE "assessmentId" IS NULL LIMIT 1;
 id | value | result | assessmentId | challengeId | createdAt | updatedAt | timeout | resultDetails | timeSpent
----+-------+--------+--------------+-------------+-----------+-----------+---------+---------------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "assessment-results" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "assessment-results" WHERE "assessmentId" IS NULL LIMIT 1;
   id    |         createdAt          | level | pixScore | emitter  | commentForJury | commentForOrganization | commentForCandidate |  status   | juryId | assessmentId
---------+----------------------------+-------+----------+----------+----------------+------------------------+---------------------+-----------+--------+--------------
 2993148 | 2020-10-15 08:15:42.677+00 |       |       54 | Jury Pix |                |                        |                     | validated | 601552 |
(1 row)

pix_datawar_7855=> SELECT * FROM  "assessment-results" WHERE "juryId" IS NULL LIMIT 1;
SELECT * FROM  "assessment-results" WHERE "juryId" IS NULL LIMIT 1;
 id |         createdAt          | level | pixScore | emitter  | commentForJury | commentForOrganization | commentForCandidate |  status   | juryId | assessmentId
----+----------------------------+-------+----------+----------+----------------+------------------------+---------------------+-----------+--------+--------------
  1 | 2017-11-21 21:30:12.933+00 |     3 |       30 | PIX-ALGO | Computed       |                        |                     | validated |        |       185131
(1 row)

pix_datawar_7855=> SELECT * FROM  "assessments" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "campaignParticipationId" IS NULL LIMIT 1;
   id    |                       courseId                       |         createdAt          |         updatedAt          | userId |         type          |   state   |   competenceId    | campaignParticipationId | isImpro
ving | certificationCourseId | lastQuestionDate | lastChallengeId
---------+------------------------------------------------------+----------------------------+----------------------------+--------+-----------------------+-----------+-------------------+-------------------------+--------
-----+-----------------------+------------------+-----------------
 4172292 | [NOT USED] CompetenceId is in Competence Evaluation. | 2020-03-02 15:14:31.776+00 | 2020-03-02 15:30:49.727+00 | 631833 | COMPETENCE_EVALUATION | completed | recfr0ax8XrfvJ3ER |                         | f
     |                       |                  |
(1 row)

pix_datawar_7855=> SELECT * FROM  "assessments" WHERE "certificationCourseId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "certificationCourseId" IS NULL LIMIT 1;
   id    |                       courseId                       |         createdAt          |         updatedAt          | userId |         type          |   state   |   competenceId    | campaignParticipationId | isImpro
ving | certificationCourseId | lastQuestionDate | lastChallengeId
---------+------------------------------------------------------+----------------------------+----------------------------+--------+-----------------------+-----------+-------------------+-------------------------+--------
-----+-----------------------+------------------+-----------------
 4172292 | [NOT USED] CompetenceId is in Competence Evaluation. | 2020-03-02 15:14:31.776+00 | 2020-03-02 15:30:49.727+00 | 631833 | COMPETENCE_EVALUATION | completed | recfr0ax8XrfvJ3ER |                         | f
     |                       |                  |
(1 row)

pix_datawar_7855=> SELECT * FROM  "assessments" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "assessments" WHERE "userId" IS NULL LIMIT 1;
   id   |     courseId      |         createdAt          |         updatedAt          | userId | type |   state   | competenceId | campaignParticipationId | isImproving | certificationCourseId | lastQuestionDate | lastChal
lengeId
--------+-------------------+----------------------------+----------------------------+--------+------+-----------+--------------+-------------------------+-------------+-----------------------+------------------+---------
--------
 376872 | rec8rnpOgmfZyd2Ng | 2018-04-14 10:10:19.831+00 | 2018-04-14 10:10:19.831+00 |        | DEMO | completed |              |                         | f           |                       |                  |
(1 row)


pix_datawar_7855=> SELECT * FROM  "authentication-methods" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "authentication-methods" WHERE "userId" IS NULL LIMIT 1;
 id | userId | identityProvider | authenticationComplement | externalIdentifier | createdAt | updatedAt
----+--------+------------------+--------------------------+--------------------+-----------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "badge-acquisitions" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "badge-acquisitions" WHERE "campaignParticipationId" IS NULL LIMIT 1;
 id  |           createdAt           | userId | badgeId | campaignParticipationId |           updatedAt
-----+-------------------------------+--------+---------+-------------------------+-------------------------------
 632 | 2020-06-29 08:19:28.681029+00 | 853283 |       1 |                         | 2020-06-29 08:19:28.681029+00
(1 row)

pix_datawar_7855=> SELECT * FROM  "badge-criteria" WHERE "badgeId" IS NULL LIMIT 1;
SELECT * FROM  "badge-criteria" WHERE "badgeId" IS NULL LIMIT 1;
 id | scope | threshold | badgeId | partnerCompetenceIds
----+-------+-----------+---------+----------------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "badge-partner-competences" WHERE "badgeId" IS NULL LIMIT 1;
SELECT * FROM  "badge-partner-competences" WHERE "badgeId" IS NULL LIMIT 1;
 id | name | skillIds | badgeId
----+------+----------+---------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "badges" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "badges" WHERE "targetProfileId" IS NULL LIMIT 1;
 id |              altMessage              |                                                    imageUrl                                                    |                 message                 | targetProfileId |
      key           | title | isCertifiable
----+--------------------------------------+----------------------------------------------------------------------------------------------------------------+-----------------------------------------+-----------------+-----
--------------------+-------+---------------
 34 | Bravo pour votre badge Socle de base | https://storage.gra.cloud.ovh.net/v1/AUTH_27c5a6d3d35841a5914c7fb9a8e96345/pix-images/badges/socle-de-base.svg | Bravo, vous avez le badge Socle de base |                 | MAIR
IE_PARIS_SOCLE_BASE |       | f
(1 row)

pix_datawar_7855=> SELECT * FROM  "campaign-participations" WHERE "campaignId" IS NULL LIMIT 1;
SELECT * FROM  "campaign-participations" WHERE "campaignId" IS NULL LIMIT 1;
 id | campaignId | createdAt | isShared | sharedAt | participantExternalId | userId | validatedSkillsCount | isImproved
----+------------+-----------+----------+----------+-----------------------+--------+----------------------+------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "campaign-participations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "campaign-participations" WHERE "userId" IS NULL LIMIT 1;
 id | campaignId | createdAt | isShared | sharedAt | participantExternalId | userId | validatedSkillsCount | isImproved
----+------------+-----------+----------+----------+-----------------------+--------+----------------------+------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "campaigns" WHERE "creatorId" IS NULL LIMIT 1;
SELECT * FROM  "campaigns" WHERE "creatorId" IS NULL LIMIT 1;
 id | name | code | organizationId | creatorId | createdAt | targetProfileId | idPixLabel | title | customLandingPageText | archivedAt | type | externalIdHelpImageUrl | alternativeTextToExternalIdHelpImage | isForAbsoluteN
ovice | customResultPageText | customResultPageButtonText | customResultPageButtonUrl | multipleSendings
----+------+------+----------------+-----------+-----------+-----------------+------------+-------+-----------------------+------------+------+------------------------+--------------------------------------+---------------
------+----------------------+----------------------------+---------------------------+------------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "campaigns" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "campaigns" WHERE "targetProfileId" IS NULL LIMIT 1;
   id   |     name     |   code    | organizationId | creatorId |         createdAt          | targetProfileId | idPixLabel | title | customLandingPageText |         archivedAt         |        type         | externalIdHel
pImageUrl | alternativeTextToExternalIdHelpImage | isForAbsoluteNovice | customResultPageText | customResultPageButtonText | customResultPageButtonUrl | multipleSendings
--------+--------------+-----------+----------------+-----------+----------------------------+-----------------+------------+-------+-----------------------+----------------------------+---------------------+--------------
----------+--------------------------------------+---------------------+----------------------+----------------------------+---------------------------+------------------
 156609 | CLERGET-PIX2 | DUWPSN181 |          10874 |    732081 | 2020-11-16 03:31:21.391+00 |                 |            |       |                       | 2020-11-16 03:37:43.954+00 | PROFILES_COLLECTION |
          |                                      | f                   |                      |                            |                           | f
(1 row)

pix_datawar_7855=> SELECT * FROM  "certification-candidates" WHERE "schoolingRegistrationId" IS NULL LIMIT 1;
SELECT * FROM  "certification-candidates" WHERE "schoolingRegistrationId" IS NULL LIMIT 1;
 id |   firstName    | lastName |  birthCity  | externalId | birthdate  |           createdAt           | sessionId | extraTimePercentage | birthProvinceCode | birthCountry | userId | email | resultRecipientEmail | schooli
ngRegistrationId | birthPostalCode | birthINSEECode | sex
----+----------------+----------+-------------+------------+------------+-------------------------------+-----------+---------------------+-------------------+--------------+--------+-------+----------------------+--------
-----------------+-----------------+----------------+-----
  1 | MOHAMED OUAMAR | BERDOUS  | BENI-DOUALA |            | 1995-12-12 | 2019-10-26 16:55:19.139809+00 |      3477 |                     | 99                | ALGERIE      |        |       |                      |
                 |                 |                |
(1 row)

pix_datawar_7855=> SELECT * FROM  "certification-candidates" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-candidates" WHERE "userId" IS NULL LIMIT 1;
 id |   firstName    | lastName |  birthCity  | externalId | birthdate  |           createdAt           | sessionId | extraTimePercentage | birthProvinceCode | birthCountry | userId | email | resultRecipientEmail | schooli
ngRegistrationId | birthPostalCode | birthINSEECode | sex
----+----------------+----------+-------------+------------+------------+-------------------------------+-----------+---------------------+-------------------+--------------+--------+-------+----------------------+--------
-----------------+-----------------+----------------+-----
  1 | MOHAMED OUAMAR | BERDOUS  | BENI-DOUALA |            | 1995-12-12 | 2019-10-26 16:55:19.139809+00 |      3477 |                     | 99                | ALGERIE      |        |       |                      |
                 |                 |                |
(1 row)

pix_datawar_7855=> SELECT * FROM  "certification-center-memberships" WHERE "certificationCenterId" IS NULL LIMIT 1;
SELECT * FROM  "certification-center-memberships" WHERE "certificationCenterId" IS NULL LIMIT 1;
 id | userId | certificationCenterId | createdAt
----+--------+-----------------------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "certification-center-memberships" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-center-memberships" WHERE "userId" IS NULL LIMIT 1;
 id | userId | certificationCenterId | createdAt
----+--------+-----------------------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "certification-challenges" WHERE "courseId" IS NULL LIMIT 1;
SELECT * FROM  "certification-challenges" WHERE "courseId" IS NULL LIMIT 1;
 id | challengeId | competenceId | associatedSkillName | courseId | createdAt | updatedAt | associatedSkillId | isNeutralized | certifiableBadgeKey
----+-------------+--------------+---------------------+----------+-----------+-----------+-------------------+---------------+---------------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "certification-courses" WHERE "sessionId" IS NULL LIMIT 1;
SELECT * FROM  "certification-courses" WHERE "sessionId" IS NULL LIMIT 1;
 id  |           createdAt           |           updatedAt           | userId | completedAt | firstName | lastName | birthdate | birthplace | sessionId | externalId | isPublished | isV2Certification | examinerComment | has
SeenEndTestScreen | verificationCode | maxReachableLevelOnCertificationDate | isCancelled | birthPostalCode | birthINSEECode | sex | birthCountry
-----+-------------------------------+-------------------------------+--------+-------------+-----------+----------+-----------+------------+-----------+------------+-------------+-------------------+-----------------+----
------------------+------------------+--------------------------------------+-------------+-----------------+----------------+-----+--------------
 126 | 2017-12-12 10:47:59.153088+00 | 2017-12-12 10:47:59.153088+00 |  24532 |             |           |          |           |            |           |            | f           | f                 |                 | f
                  |                  |                                    5 | f           |                 |                |     |
(1 row)

pix_datawar_7855=> SELECT * FROM  "certification-courses" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-courses" WHERE "userId" IS NULL LIMIT 1;
 id |           createdAt           |           updatedAt           | userId | completedAt | firstName | lastName | birthdate | birthplace | sessionId | externalId | isPublished | isV2Certification | examinerComment | hasS
eenEndTestScreen | verificationCode | maxReachableLevelOnCertificationDate | isCancelled | birthPostalCode | birthINSEECode | sex | birthCountry
----+-------------------------------+-------------------------------+--------+-------------+-----------+----------+-----------+------------+-----------+------------+-------------+-------------------+-----------------+-----
-----------------+------------------+--------------------------------------+-------------+-----------------+----------------+-----+--------------
  1 | 2017-11-29 11:16:57.897549+00 | 2017-11-29 11:16:57.897549+00 |        |             |           |          |           |            |           |            | f           | f                 |                 | f
                 |                  |                                    5 | f           |                 |                |     |
(1 row)

pix_datawar_7855=> SELECT * FROM  "certification-issue-reports" WHERE "certificationCourseId" IS NULL LIMIT 1;
SELECT * FROM  "certification-issue-reports" WHERE "certificationCourseId" IS NULL LIMIT 1;
 id | certificationCourseId | category | description | createdAt | updatedAt | subcategory | questionNumber | resolvedAt | resolution
----+-----------------------+----------+-------------+-----------+-----------+-------------+----------------+------------+------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "competence-evaluations" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "competence-evaluations" WHERE "assessmentId" IS NULL LIMIT 1;
 id | assessmentId | userId | competenceId | createdAt | updatedAt | status
----+--------------+--------+--------------+-----------+-----------+--------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "competence-evaluations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "competence-evaluations" WHERE "userId" IS NULL LIMIT 1;
 id | assessmentId | userId | competenceId | createdAt | updatedAt | status
----+--------------+--------+--------------+-----------+-----------+--------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "feedbacks" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "feedbacks" WHERE "assessmentId" IS NULL LIMIT 1;
 id | content | assessmentId | challengeId | createdAt | updatedAt | category | answer
----+---------+--------------+-------------+-----------+-----------+----------+--------
(0 rows)

pix_datawar_7855=> --  SELECT * FROM  "knowledge-elements" WHERE "answerId" IS NULL LIMIT 1;
pix_datawar_7855=> --  SELECT * FROM  "knowledge-elements" WHERE "assessmentId" IS NULL LIMIT 1;
pix_datawar_7855=> --  SELECT * FROM  "knowledge-elements" WHERE "userId" IS NULL LIMIT 1;
pix_datawar_7855=> SELECT * FROM  "memberships" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "organizationId" IS NULL LIMIT 1;
 id | userId | organizationId | organizationRole | createdAt | updatedAt | disabledAt | updatedByUserId
----+--------+----------------+------------------+-----------+-----------+------------+-----------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "memberships" WHERE "updatedByUserId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "updatedByUserId" IS NULL LIMIT 1;
  id  | userId | organizationId | organizationRole | createdAt | updatedAt | disabledAt | updatedByUserId
------+--------+----------------+------------------+-----------+-----------+------------+-----------------
 1638 |  11908 |            981 | MEMBER           |           |           |            |
(1 row)

pix_datawar_7855=> SELECT * FROM  "memberships" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "userId" IS NULL LIMIT 1;
 id | userId | organizationId | organizationRole | createdAt | updatedAt | disabledAt | updatedByUserId
----+--------+----------------+------------------+-----------+-----------+------------+-----------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "organization-invitations" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "organization-invitations" WHERE "organizationId" IS NULL LIMIT 1;
 id | organizationId | email | status | createdAt | updatedAt | code | role
----+----------------+-------+--------+-----------+-----------+------+------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "organization-tags" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "organization-tags" WHERE "organizationId" IS NULL LIMIT 1;
 id | organizationId | tagId | createdAt | updatedAt
----+----------------+-------+-----------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "organization-tags" WHERE "tagId" IS NULL LIMIT 1;
SELECT * FROM  "organization-tags" WHERE "tagId" IS NULL LIMIT 1;
 id | organizationId | tagId | createdAt | updatedAt
----+----------------+-------+-----------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "pole-emploi-sendings" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "pole-emploi-sendings" WHERE "campaignParticipationId" IS NULL LIMIT 1;
 id | campaignParticipationId | type | isSuccessful | responseCode | payload | createdAt
----+-------------------------+------+--------------+--------------+---------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "schooling-registrations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "schooling-registrations" WHERE "userId" IS NULL LIMIT 1;
   id   | userId | organizationId | firstName | lastName | birthdate  |           createdAt           |           updatedAt           | preferredLastName | middleName | thirdName | birthCity | birthCityCode | birthProvince
Code | birthCountryCode |   MEFCode   | status | nationalStudentId | division | email | studentNumber | department | educationalTeam | group | diploma | nationalApprenticeId | sex | isDisabled
--------+--------+----------------+-----------+----------+------------+-------------------------------+-------------------------------+-------------------+------------+-----------+-----------+---------------+--------------
-----+------------------+-------------+--------+-------------------+----------+-------+---------------+------------+-----------------+-------+---------+----------------------+-----+------------
 829717 |        |           4015 | Mattéo    | LAMBERT  | 2006-03-02 | 2020-02-10 12:13:59.928037+00 | 2020-02-10 12:13:59.928037+00 |                   | Ludo       |           |           | 44003         | 044
     | 100              | 10110001110 | ST     | 082042380CG       | 5A       |       |               |            |                 |       |         |                      |     | f
(1 row)

pix_datawar_7855=> SELECT * FROM  "sessions" WHERE "assignedCertificationOfficerId" IS NULL LIMIT 1;
SELECT * FROM  "sessions" WHERE "assignedCertificationOfficerId" IS NULL LIMIT 1;
  id  |    certificationCenter     |       address       | room |     examiner     |    date    |   time   |     description      |         createdAt          | accessCode | certificationCenterId | examinerGlobalComment |
finalizedAt | resultsSentToPrescriberAt | publishedAt | assignedCertificationOfficerId
------+----------------------------+---------------------+------+------------------+------------+----------+----------------------+----------------------------+------------+-----------------------+-----------------------+-
------------+---------------------------+-------------+--------------------------------
 5616 | Université de Haute-Alsace | Campus Grillenbreit | F208 | François Collas  | 2020-03-18 | 15:00:00 | 5 étudiants LP AQSEE+| 2020-02-17 14:13:44.665+00 | MDKH39     |                    17 |                       |
            |                           |             |
      |                            |                     |      |                  |            |          |                      |                            |            |                       |                       |
            |                           |             |
(1 row)

pix_datawar_7855=> SELECT * FROM  "sessions" WHERE "certificationCenterId" IS NULL LIMIT 1;
SELECT * FROM  "sessions" WHERE "certificationCenterId" IS NULL LIMIT 1;
 id |       certificationCenter        | address | room |    examiner    |    date    |   time   | description |           createdAt           | accessCode | certificationCenterId | examinerGlobalComment | finalizedAt | re
sultsSentToPrescriberAt | publishedAt | assignedCertificationOfficerId
----+----------------------------------+---------+------+----------------+------------+----------+-------------+-------------------------------+------------+-----------------------+-----------------------+-------------+---
------------------------+-------------+--------------------------------
 35 | Université Nice-Sophia-Antipolis | Nice    | 666  | Sophie Rapetti | 2017-12-08 | 14:30:00 |             | 2018-03-26 15:26:56.680102+00 | IIGJ53     |                       |                       |             |
                        |             |
(1 row)

pix_datawar_7855=> SELECT * FROM  "target-profile-shares" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "target-profile-shares" WHERE "organizationId" IS NULL LIMIT 1;
 id | targetProfileId | organizationId | createdAt
----+-----------------+----------------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "target-profile-shares" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "target-profile-shares" WHERE "targetProfileId" IS NULL LIMIT 1;
 id | targetProfileId | organizationId | createdAt
----+-----------------+----------------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "target-profiles" WHERE "ownerOrganizationId" IS NULL LIMIT 1;
SELECT * FROM  "target-profiles" WHERE "ownerOrganizationId" IS NULL LIMIT 1;
 id  |           name           | isPublic | ownerOrganizationId |           createdAt           | outdated |                                                       imageUrl
      | isSimplifiedAccess
-----+--------------------------+----------+---------------------+-------------------------------+----------+-----------------------------------------------------------------------------------------------------------------
------+--------------------
 736 | _Parcours de rentrée Tle | f        |                     | 2020-08-20 16:16:48.891186+00 | f        | https://storage.gra.cloud.ovh.net/v1/AUTH_27c5a6d3d35841a5914c7fb9a8e96345/pix-images/profil-cible/Illu_classeTl
e.svg | f
(1 row)

pix_datawar_7855=> SELECT * FROM  "target-profiles_skills" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "target-profiles_skills" WHERE "targetProfileId" IS NULL LIMIT 1;
 id | targetProfileId | skillId
----+-----------------+---------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "user-orga-settings" WHERE "currentOrganizationId" IS NULL LIMIT 1;
SELECT * FROM  "user-orga-settings" WHERE "currentOrganizationId" IS NULL LIMIT 1;
 id | userId | currentOrganizationId | createdAt | updatedAt
----+--------+-----------------------+-----------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "user-orga-settings" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "user-orga-settings" WHERE "userId" IS NULL LIMIT 1;
 id | userId | currentOrganizationId | createdAt | updatedAt
----+--------+-----------------------+-----------+-----------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "users_pix_roles" WHERE "pix_role_id" IS NULL LIMIT 1;
SELECT * FROM  "users_pix_roles" WHERE "pix_role_id" IS NULL LIMIT 1;
 id | user_id | pix_role_id
----+---------+-------------
(0 rows)

pix_datawar_7855=> SELECT * FROM  "users_pix_roles" WHERE "user_id" IS NULL LIMIT 1;
SELECT * FROM  "users_pix_roles" WHERE "user_id" IS NULL LIMIT 1;
 id | user_id | pix_role_id
----+---------+-------------
(0 rows)

-- 0 rows
SELECT * FROM  "account-recovery-demands" WHERE "schoolingRegistrationId" IS NULL LIMIT 1;
SELECT * FROM  "answers" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "authentication-methods" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "badge-criteria" WHERE "badgeId" IS NULL LIMIT 1;
SELECT * FROM  "badge-partner-competences" WHERE "badgeId" IS NULL LIMIT 1;
SELECT * FROM  "campaign-participations" WHERE "campaignId" IS NULL LIMIT 1;
SELECT * FROM  "campaign-participations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "campaigns" WHERE "creatorId" IS NULL LIMIT 1;
SELECT * FROM  "certification-center-memberships" WHERE "certificationCenterId" IS NULL LIMIT 1;
SELECT * FROM  "certification-center-memberships" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "certification-challenges" WHERE "courseId" IS NULL LIMIT 1;
SELECT * FROM  "certification-issue-reports" WHERE "certificationCourseId" IS NULL LIMIT 1;
SELECT * FROM  "competence-evaluations" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "competence-evaluations" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "feedbacks" WHERE "assessmentId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "memberships" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "organization-invitations" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "organization-tags" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "organization-tags" WHERE "tagId" IS NULL LIMIT 1;
SELECT * FROM  "pole-emploi-sendings" WHERE "campaignParticipationId" IS NULL LIMIT 1;
SELECT * FROM  "target-profile-shares" WHERE "organizationId" IS NULL LIMIT 1;
SELECT * FROM  "target-profile-shares" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "target-profiles_skills" WHERE "targetProfileId" IS NULL LIMIT 1;
SELECT * FROM  "user-orga-settings" WHERE "currentOrganizationId" IS NULL LIMIT 1;
SELECT * FROM  "user-orga-settings" WHERE "userId" IS NULL LIMIT 1;
SELECT * FROM  "users_pix_roles" WHERE "pix_role_id" IS NULL LIMIT 1;
SELECT * FROM  "users_pix_roles" WHERE "user_id" IS NULL LIMIT 1;