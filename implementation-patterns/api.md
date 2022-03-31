## validation

Dans ce cas préçis ça voudrait dire :
valider la structure du JSON dans le controller (vérifier qu'on a bien des clé verificationCode et pixScore par exemple)
valider dans le usecase que verificationCode et pixScore ne sont pas null
valider dans des objets du domain (ex. PixScore et VerificationCode) le format du code (regex) et eventuellement que le pixScore soit entre X et Y)

https://blog.frankdejonge.nl/where-does-validation-live/
https://ikenox.info/blog/where-to-put-validation-in-clean-architecture/

pre-handler are used for security. 
Hapi auth strategy checks the user has a token, but the token grant no other rights than pix-app
When using routes assigned to other apps (orga, certif, admin), some role check should be done
- `memberships` for orga
- `certification-center-membership ` for certif
- `users-pix-roles ` for admin

If finer-grain control is needed (eg, someone cannot change certification session if not its own), it's also done in pre-handler
When does it turns in business rule deserving to be put in use-case ?


## clean archi

Put as many business rules 
- domain model (as object properties)
- use-case

The exceptions are (related to Hapi ? Do they belong to the domain ?)
- input format validation in `config.validate` hook in router
- security in `pre-handler` 

### Injection
Dependencies (repositories, services) are injected in use-case, not in controllers & routers.

### Domain
Restrict your domain in subgroups (bounded context), and create as many model as needed:
- Session domain, certificationCandidate model;
- Supervising domain, certificationCandidate model;

It prevents having only one huge domain model:
- whose behavior is generic and does not reflect the business vocabulary;  
- whose properties may not be defined regarding its lifecycle;
 
### Repositories
Think domain model first, then create the repository that will instantiate it (get/find).

Business rules should be in the use-case, but the following is not a business rule:
- joining table



### Services
Services are not mentioned in clean architecture. There is domain services in DDD. 
They nevertheless exists in the codebase. The anti-pattern is [anemic domain model](https://martinfowler.com/bliki/AnemicDomainModel.html) 

The aim is to share code, but which code cannot be shared:
- in several use-case, putting code in domain or repository ?
- in several controller, putting code in use-case ?

A legitimate usage:
- BR on two different objects (domain model), when behavior does not fit in one of the objects
- same BR to be applied in two use-case, when the same behaviour is expected and duplication may lead to behaviour divergence 

https://1024pix.slack.com/archives/CG9R2NSRJ/p1597073931002500
