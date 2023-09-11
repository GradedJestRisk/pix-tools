SELECT
  name,
  language,
  forks_count,
  stargazers_count
FROM
  github_my_repository
  ;

--  Public repositories
WITH public_repositories AS (
    SELECT
       repo.*
    FROM
       github_my_repository repo
    WHERE 1=1
        AND repo.owner_type = 'Organization'
        AND repo.owner_login = '1024pix'
        AND repo.archived IS FALSE
        AND repo.disabled IS FALSE
        AND repo.private IS FALSE
        AND repo.is_template IS FALSE
        AND repo.fork IS FALSE
)
SELECT
    repo.name,
    repo.pushed_at,
    repo.license_name,
    repo.*
FROM public_repositories repo
ORDER BY repo.pushed_at DESC


--  Stale public repositories
WITH public_repositories AS (
    SELECT
       repo.*
    FROM
       github_my_repository repo
    WHERE 1=1
        AND repo.owner_type = 'Organization'
        AND repo.owner_login = '1024pix'
        AND repo.archived IS FALSE
        AND repo.disabled IS FALSE
        AND repo.private IS FALSE
        AND repo.is_template IS FALSE
        AND repo.fork IS FALSE
)
SELECT
    repo.name,
    repo.pushed_at,
    repo.license_name,
    repo.*
FROM public_repositories repo
WHERE repo.pushed_at < '2018-01-01'
ORDER BY repo.pushed_at DESC
;



-- No licence non-forked
WITH public_repositories AS (
    SELECT
       repo.*
    FROM
       github_my_repository repo
    WHERE 1=1
        AND repo.owner_login = '1024pix'
        AND repo.archived IS FALSE
        AND repo.disabled IS FALSE
        AND repo.private IS FALSE
        AND repo.is_template IS FALSE
        AND repo.fork IS FALSE
)
SELECT
    repo.name,
    repo.license_name,
    repo.*
FROM public_repositories repo
WHERE 1=1
--    AND repo.name = 'pix-steampipe-mod-scalingo-compliance'
--   AND public_repositories.default_branch = 'master'
     AND repo.license_name IS NULL
ORDER BY repo.name ASC
;


-- Forked / No licence
WITH public_repositories AS (
    SELECT
       repo.*
    FROM
       github_my_repository repo
    WHERE 1=1
        AND repo.owner_login = '1024pix'
        AND repo.archived IS FALSE
        AND repo.disabled IS FALSE
        AND repo.private IS FALSE
        AND repo.is_template IS FALSE
        AND repo.fork IS TRUE
)
SELECT
    repo.name,
    repo.license_name,
    repo.*
FROM public_repositories repo
WHERE 1=1
--    AND repo.name = 'pix-steampipe-mod-scalingo-compliance'
--   AND public_repositories.default_branch = 'master'
     AND repo.license_name IS NULL
ORDER BY repo.name ASC
;

-- No licence control
WITH public_repositories AS (
    SELECT
       repo.*
    FROM
       github_my_repository repo
    WHERE 1=1
        AND repo.owner_login = '1024pix'
        AND repo.archived IS FALSE
        AND repo.disabled IS FALSE
        AND repo.private IS FALSE
        AND repo.is_template IS FALSE
        AND repo.fork IS FALSE
)
SELECT
    repo.name AS resource,
    license_name,
    CASE
       WHEN repo.license_name IS NULL THEN 'alarm'
       ELSE 'ok'
    END AS status,
    CASE
       WHEN repo.license_name IS NULL THEN 'Le repository public '|| repo.name || ' n''a pas de licence' || '.'
       ELSE 'Le repository public '|| name || ' a une licence ' || license_name || '.'
    END AS reason
FROM public_repositories repo
--WHERE license_name IS NULL
ORDER BY repo.name ASC
;


