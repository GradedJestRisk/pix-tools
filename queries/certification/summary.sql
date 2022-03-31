/*

session
- créé par le centre de certif

certification-candidate
- créé lors de l'import des candidats

certification-course créé lors du début du parcours (candidat) que certif
- 1 seul enreg, à quoi sert-il ?
- son id  apparaît dans l'IHM sur le parcours de  certification "N° de certification 18002"

assessments créé lors du début du parcours (campagne aussi)
- 1 seul, avec statut (state = "started" au début, puis "completed" à la fin du parcours)

certification-challenges
- N questions (challengeId) créées au début du parcours

answers créé lors du parcours
- questions à poser (N)
- réponses apportées (mise à jour du statut)

assessment-results
- créé lors de la finalisation de la session (scoring)
- status = validated pour le statut courant

*/

