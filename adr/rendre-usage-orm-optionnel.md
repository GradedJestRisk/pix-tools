# 28. Rendre l'usage de l'ORM optionnel
Date : 2021-07-11

## État
En cours

## Besoin initial
Le stockage des données dans une base de données est (différente)[https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping]
de celle d'un Object Javascript, notamment lorsqu'il contient des collections.

De plus, selon Robert Martin, plusieurs applications OOP utilisant la même BDD auront des
objets métiers différents.

(Objects and data structures)[https://blog.cleancoder.com/uncle-bob/2019/06/16/ObjectsAndDataStructures.html]
> Each application will have a different object model, tuned to that application’s behavior.
> The database schema is not tuned for just one application; it must serve the entire enterprise.
> So the structure of that data is a compromise between many different applications.

Pour ne pas devoir effectuer manuellement les opérations de mapping entre API et BDD,
un ORM a été choisi. Il permet de déclarer le mapping de manière déclarative une seule
fois, puis d'utiliser une API (pour lire, écrire, mettre à jour).

Deux ans après sa mise en place, Bookshelf répond-t-il au besoin initial ?

## Etat des lieux
Sur plusieurs axes, Bookshelf ne donne pas satisfaction.

### OOP

#### Résumé
Le besoin étant d'avoir un mapping flexible entre table de BDD et objet métier,
si le besoin est rempli, les objets métiers seraient décorellés des tables.
Or, on constate un mapping 1:1 entre table et objet du domaine.

Dans les faits, voir ci-dessous, il est impossible de mapper un objet avec
un ensemble de colonne de plusieurs tables en utilisant uniquement le modèle.

#### Détails

Il n'est pas possible de lire uniquement certaines colonnes d'une table
[issue](https://github.com/bookshelf/bookshelf/issues/70),
en utilisant uniquement le modèle: il faut filtrer les données manuellement.
[badge-acquisition-repository.js](../api/lib/infrastructure/repositories/badge-acquisition-repository.js)
```javascript
    const collectionResult = await BookshelfBadgeAcquisition
      .where({ userId })
      .where('badgeId', 'in', badgeIds)
      .fetchAll({ columns: ['badge-acquisitions.badgeId'], require: false });
```

Il n'est pas possible de ne pas persister certaines propriétés [issue](https://github.com/bookshelf/bookshelf/issues/1101),
en utilisant uniquement le modèle: il faut filtrer les données manuellement.
[certification-issue-report-repository](../api/lib/infrastructure/repositories/certification-issue-report-repository)
```javascript
  const newCertificationIssueReport = await new CertificationIssueReportBookshelf(
  omit(certificationIssueReport, ['isImpactful']),
  ).save();)
```

### Clean architecture

La clean architecture (permet l'usage de l'ORM)[https://groups.google.com/g/clean-code-discussion/c/EyTIuGt_yTA/discussion],
mais préconise le pattern Gateway 
pour que le domaine ne contienne aucun détail de persistence. 
Il en découle la séparation des objets du domaine 
d'avec les objets instanciés par Bookshelf, c’est-à-dire des classes du domaine
et des modèles Bookshelf.

En pratique, cela signifie que l'instanciation des objets métier sera effectué en 
invoquant leur constructeur, à partir des objets renvoyés par Bookshelf. Pour éviter
les erreurs, un composant automatise ces instanciations, mais il ne prend pas en compte 
tous les cas de figures. La compréhension et la maintenance de ce composant introduisent
de la complexité.

(bookshelf-to-domain-converter)[../api/lib/infrastructure/utils/bookshelf-to-domain-converter.js]
(import des classes métier)[../api/lib/domain/models/index.js]

### Performance

Il ne permet pas d'effectuer des jointures natives entre tables (JOIN)
(issue)[https://github.com/bookshelf/bookshelf/issues/763]

Il n'est pas possible de spécifier dans le modèle des options eager/lazy loading.
(issue)[https://github.com/bookshelf/bookshelf/issues/729]

Il ne permet pas d'implémenter un cache local comme Hibernate
(issue)[https://github.com/bookshelf/bookshelf/issues/223]
Le [plugin existant](https://www.npmjs.com/package/bookshelf-cache-redis)
est peu utilisé, sa maintenabilité est limite.

### Divers

Bookshelf ayant une approche agnostique de la BDD, il utilise un query-builder (Knex). 
En conséquence, il n'utilise pas toutes les fonctionnalités de PostgreSQL, 
par exemple le niveau d'isolation des transactions
[issue](https://github.com/bookshelf/bookshelf/issues/1621)

Nous n'avons pas besoin de changer de BDD, mais l'effet indirect des limitations
est de devoir trouver des solutions de contournement, par exemple 
dans (cette PR)[https://github.com/1024pix/pix/pull/3109/files] sur l'utilisation de `IN`

## Solution

Il est possible d'effectuer un mapping flexible entre BDD et objet métier en
effectuant ce mapping manuellement en SQL. Il sera toujours effectué dans les 
repositories (pattern gateway de la clean architecture).

Deux implémentations sont possibles:
- écrire du SQL natif et le fournir au client postgres pour node;
- utiliser un query-builder qui offre un DSL de SQL en Javascript.

