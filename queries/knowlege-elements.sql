-- KE
SELECT
   ke.*
FROM "knowledge-elements" ke
WHERE 1=1
   AND ke.id = 5423
--ORDER
;

-- Snapshot
SELECT
   ke_sn.*
FROM "knowledge-element-snapshots" ke_sn
WHERE 1=1
   AND ke_sn.id = 1
--ORDER
;

-- Snapshot
SELECT ke_sn.* FROM "knowledge-element-snapshots" ke_sn WHERE ke_sn.id = 1;

SELECT jsonb_pretty(snapshot) FROM "knowledge-element-snapshots" ke_sn WHERE ke_sn.id = 1;