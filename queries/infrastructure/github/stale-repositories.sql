
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



-- Stale repositories / control
WITH public_repositories AS (
    SELECT
       repo.name,
       repo.pushed_at
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
    CASE
       WHEN repo.pushed_at < '2019-01-01' THEN 'alarm'
       ELSE 'ok'
    END AS status,
    CASE
       WHEN repo.pushed_at < '2019-01-01' THEN 'Le repository public '|| repo.name || ' n''a pas eu de push depuis 2019 (dernier push: ' || repo.pushed_at ||  ').'
       ELSE 'Le repository public '|| repo.name || ' a un push depuis 2019 (dernier push: ' || repo.pushed_at ||  ').'
    END AS reason,
    CASE
       WHEN repo.pushed_at < '2019-01-01' THEN 'Archive it visting https://github.com/1024pix/' || repo.name || '/settings'
    END AS fix
FROM public_repositories repo
ORDER BY repo.pushed_at ASC
;


