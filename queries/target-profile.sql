SELECT
     'target profile =>'
    ,tp.id
    ,tp.name
    ,tp."isPublic"
    ,tp.outdated
     ,tp.*
FROM "target-profiles" tp
WHERE 1=1
    -- AND tp.name LIKE '%–%'
    AND tp."isPublic" IS TRUE
;

-- Private target profiles / owner
SELECT
    'organization =>'
    ,o.name
     ,'target profile =>'
     ,tp.id
    ,tp.name
    ,tp."isPublic"
    ,tp.outdated
    ,tp."ownerOrganizationId"
    ,'target-profiles=>'
    ,tp.*
FROM "target-profiles" tp
    INNER JOIN organizations o on tp."ownerOrganizationId" = o.id
WHERE 1=1
    -- AND tp.name LIKE '%–%'
    AND tp."isPublic" IS FALSE
;

-- Private target profiles / inheriters
SELECT *
FROM "target-profile-shares";

-- Private target profiles + organizations
SELECT
    tp.name,
    o.name
FROM "target-profile-shares" tgs
    INNER JOIN "target-profiles" tp on tp.id = tgs."targetProfileId"
    INNER JOIN organizations o on tp."ownerOrganizationId" = o.id
WHERE 1=1
    AND tp."isPublic" IS FALSE
    --AND t.name = ''
;