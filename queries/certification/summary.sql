/*

session
- créé par le centre de certif
- finalizedAt alimenté par PUT sur /api/sessions/{id}/finalization + examinerGlobalComment (si incident sur toute la session)

certification-candidate
- lié à la session
- créé lors de l'import des candidats (manuel ou par fichier)
- userId renseigné une fois que l'utilisateur a rejoint le parcours

certification-course créé lors du début du parcours (candidat) que certif (pas parcours libre)
- 1 seul enreg par candidat
- son id  apparaît dans l'IHM sur le parcours de  certification "N° de certification 18002"
- lié à l'assessment indirectement (assessments.certificationCourseId si parcours de certif, NULL sinon)
- lié à la session et à l'utilisateur
- motif abandon (abort reason - pas ENUM)) mis à jour par la route POST /api/certification-reports/{id}/abort dans l'écran de pré-finalisation et par la finalisation
- isCancelled est mis 	
    - à true une fois la session finalisée (pas lorsqu'on renseigne un motif)
    - ou lorsqu'on annule une certif via pix-amdin (POST /api/admin/certification-courses/{id}/cancel)
- completedAt une fois la dernière question posée + scoring fini

assessments créé lors du début du parcours (parcours libre, campagne ou certif)
- 1 seul, avec statut (state = "started" au début, puis "completed" à la fin du parcours ou "endedBySupervisor")
-

challenges
- référentiel

certification-challenges
- N questions par parcours (challengeId)
- créées au début du parcours (de certif, pas libre)

answers créé lors du parcours
- réponses apportées (N par parcours)
- créé par POST sur /answers avec payload assessmentId + challengeId
- status ?

assessment-results
- 1 par session / candidat
- créé lors de la finalisation de la session (scoring)
- status = validated si certification obtenue

complementary-certifications
- libellé

complementary-certification-courses
- FK vers certification-courses

complementary-certification-subscriptions
- inscription à la certif complémentaire
- 1 enreg
- même que dans complementary-certification-courses

complementary-certification-course-result
- résultat de la certif complémentaire ( forcément inscrit?)
- 1 enreg
- acquired (true/false)
- badge


certifcation-issue-reports
- créé dans l'écran de finalisation (appel de POST /api/certification-reports/{id}/certification-issue-reports)
- categoy + subcategory (pas ENUM)
- resolvedAt + resolution alimenté par auto-jury ou métier via pix-admin (résoudre) 


Modèles

CertificationReport = abandon d'un utilisateur (pas signalement)
IssueReport = Signalement
FinalizedSession = table finalized-sessions


Events
finalisation session (route) => EVT auto-jury => EVT session-finalized


L'auto-jury est lancé automatiquement lors de la dernière réponse et lors de la finalisation
L'auto-jury peut être relancé via script launch-auto-jury-for-session

le scoring est lancé par l'auto-jury
le scoring est lancé lorsqu'on neutralise ou déneutralise uen question

*/

