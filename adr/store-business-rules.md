# 0028 - Store business rules in API

A business rule is some behaviour.

## Architecture

### Domain layer
Hexagonal architecture aims to separate domain layer from implementation layer.
Clean architecture has the same goal, and further describe the domain layer:
- entreprise business rules are stored in domain objects;
- application business rules are stored in use-case, which don't have to be objects.

Entreprise business rules are rules shared by all applications, whereas
application business rules is the way this very application does the job to 
ensure them.

In this API, there is a straight 1:1 mapping between routes and usecase.
Are there routes which are used by several application ? 
If the same business rules applies in several routes, what will we do ?

Clean code doesn't mention this situation, so we need to make the best guess.
Let's start by using existing elements:
- use cases
- domain objects
- repositories

### Sharing in objects

The most straightforward answers would be to store such behaviour in domain objects.
They're supposed to store business rules that can be applied in every application.
If we store them here anyway, we should be careful not to cause side effects in other
usecase or applications.

However, if such behavior involve many data, we would have to load it all into the
memory as object properties.

The most common setting is:
- a relational database is involved, as a single instance
- multiple API containers are spinned up 
- this database is not hosted in the same containers.

This may not be the right thing to do :
- the dataset has to be transferred throught network, which may have limited capacity;
- it may not be possible without swapping, as containers have limited memory.


### Sharing in use cases

If we want to avoid putting use-case specific business rules in objects, what about use-cases ?

We can have the same business rules applied in several use-case with a similar implementation.
Such code can be said to be duplicated. However, the point is :
- how much code is similar
- does it stand for most of the use case.

Some duplication is safe, as long are there's enough specific code ine the use-case. 
> Worst / evuil...

Keep in mind the performance penalty

### Sharing in services 

If a large set of business rules is shared between several use-case by duplication, some 
errors may slip in. We can then decide to extract such implementation in a service:
- a service can only be called by several use-case;
- a service cannot be called by controller or repositories;
- a service can call a repository and other services.

Keep in mind the performance penalty

### Sharing in repositories (gateway)

If a business rule involve a large amount of data, we cannot but ask the database to apply the 
business rules, so we have to implement business rules in SQL (or any DSL that will generate SQL).
This may involve: 
- filter: retrieve all users which are reconciled
- joins:  retrieve all users which have joined at least one campaign

The business rules can be stated explicitly by:
- creating a function for our specific case 
- naming it accordingly

Eg: `getLastReconciledUserByBirthdateAndINE` instead of 
`getUser`, called from two use-cases with different parameters 

Doing so, the developer has to read repository code to get all business rules.
However, performance issue can still happen, this time in the database.
Nested queries on large tables, including analytic functions, can load the database.
It may slow down other queries, and the API call itself may be interrumpted by the router anyway
if the maximum allowed time (1 minutes) is reached.

## Conclusion
Business rules may be stored in many places, tradeoff being:
- code maintainability
- load splitting between a slowly vertical-scalable database and a quickly horizontal-scalable API
