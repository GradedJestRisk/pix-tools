# Est-il obligatoire d'implémenter un use-case dans toutes les situations ?

## Contexte
Nous avons besoin de faire évoluer l'implémentation des RG fonctionnelles facilement.

### Comment implémenter les RG fonctionnelles ?
La solution adoptée est, dans l'[architecture hexagonale](https://blog.octo.com/architecture-hexagonale-trois-principes-et-un-exemple-dimplementation/) :
- encapsuler les RG dans une zone dédiée, appelée *business Logic*
- préserver cette zone du reste de l'application en y injectant les dépendances
  
Un exemple de dépendance, *server-side*, est la persistence, via un composant repository.

La [clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) 
distingue deux niveaux de RG fonctionnelles. Si elles s'appliquent :
- à toutes les applications du SI, ce sont des *entreprise business rules*
- uniquement à l'application, ce sont des *application business rules*

Il est possible d'implémenter la *business logic* zone avec deux types de composants :
- les *entities* contiennent les *entreprise business rules* , qui sont valables mêmes le système était manuel (ex: le calcul de la TVA) 
- les [*use-case*](../Usecase.md) contiennent les *application business rules* , qui décrivent comment l'application manipule ces *entities* 

> A use-case is a description of the way that an automated system is used. It specifies the input
> to be provided by the user, the output to be returned to the user, and the processing steps
> involved in producing that output. *

### Le use-case
Même si la distinction entre les niveaux *entreprise* et *application* n'est pas évidente,
il est clair que ces RG ne sont pas liées à des notions concrètes de communication (http)
ou de persistance (BDD).

> The use-case does not describe the user interface other than to informally specify the data coming 
> in from that interface and then data going back out through that interface. From the use-case, it is
> impossible to tell whether the application is delivered on the web or on a thick server. *

Toute validation, par exemple une validation de la structure et du type de payload dans la couche
*user-side* , [n'est pas une RG](https://ikenox.info/blog/where-to-put-validation-in-clean-architecture) et ne doit pas être systématiquement centralisée dans le use-case.
Par contre, une validation dans la zone *business logic* est une RG. **

### Le problème
Considérons ces deux cas

Un controller sans use-case
```javascript
async createResetDemand(request, h) {
    const user = userSerializer.deserialize(request.payload);
    await userRepository.isUserExistingByEmail(user.email);
    const temporaryKey = resetPasswordService.generateTemporaryKey();
    const passwordResetDemand = await resetPasswordDemandRepository.create({ email: user.email, temporaryKey });
    const locale = extractLocaleFromRequest(request);
    await mailService.sendResetPasswordDemandEmail(user.email, locale, temporaryKey);
    const serializedPayload = passwordResetSerializer.serialize(passwordResetDemand.attributes);

    return h.response(serializedPayload).created();
},
```
Un use-case réduit à un appel de dépendance
```javascript
module.exports = function getTargetProfileDetails({ targetProfileId, targetProfileWithLearningContentRepository }) {
  return targetProfileWithLearningContentRepository.get({ id: targetProfileId });
};
```

Dans les deux cas, la question est la même : y a-t-il toujours un use-case ?
- dans le premier cas, serait-il correct de ne pas créer de use-case
- dans le deuxième cas, était-il correct d'extraire ce code dans un use-case

Ce qui revient à se demander : y a-t-il *toujours* des RG fonctionnelles ?

### Exploration du problème
Un moyen de répondre à cette question est de lister ce qui ne relève pas du use-case :
- la désérialisation de la requête et la sérialisation de la réponse appartiennent au *controller*
> A well-formed use-case should have no inkling about the way that data is communicated to the user,
> or to any other component. We certainly don't want the code with the use case class to know about
> HTML or SQL ! *
- les [scénarios alternatifs](https://github.com/1024pix/pix/pull/2411), effectué via les erreurs du domaine dans [le mapper](api/lib/application/error-manager.js) 
- la gestion des scopes / authorize, effectué dans un pre-handler, par exemple [checkRequestedUserIsAuthenticatedUser](api/lib/application/security-pre-handlers.js)
- l'appel d'un composant indispensable à l'action, dont l'accès est inconditionnel par exemple un repository si l'on doit lire des données   

S'il reste des éléments, ils peuvent être isolés dans un use-case.

### Les solutions

Dans cette situation, faut-il :
- déplacer le code dans le `controller`
- ou le garder dans un fichier sous le dossier `use-case` (même s'il n'est pas un use-case) ?

#### Solution n°1 : Ne pas créer systématiquement un use-case par route

Avantages :
- conforme aux règles de la Clean Architecture, donc plus compréhensible par les nouveaux
- moins verbeux : deux fichiers de moins (implémentation + test)

Inconvénients :
- arbitrage à effectuer à chaque modification de la route : est-ce une RG fonctionnelle ?

#### Solution n°2 : Créer systématiquement un fichier sous le dossier use-case

Avantages :
- pas d'arbitrage sur la définition d'une RG

Inconvénients :
- non conforme aux règles de la Clean Architecture, donc moins compréhensible par les nouveaux
- plus verbeux


## Notes
La présence d'un service n'indique pas nécessairement la présence d'une RG.

Dans l'extrait ci-dessous :
- le composant `tokenService` n'implémente pas de RG
- le composant `resetPasswordService` implémente une RG : la requête sera refusée
  (`PasswordResetDemandNotFoundError`) si l'utilisateur n'avait pas fait une demande préalable

```javascript
module.exports = async function getUserByResetPasswordDemand({
  temporaryKey,
  resetPasswordService,
  tokenService,
  userRepository,
}) {
  await tokenService.decodeIfValid(temporaryKey);
  const { email } = await resetPasswordService.verifyDemand(temporaryKey);
  return userRepository.getByEmail(email);
};
```

* : Clean Architecture, Robert Martin - Chapter 20: Business Rules

