-- Invoice / By region and date
SELECT
    'Invoice=>'
     ,nvc.id
     ,nvc.invoice_number
     ,TO_CHAR(nvc.billing_month,'YYYY-MM')
     ,nvc.total_price
     ,nvc.state
    ,'scalingo_invoice'
    ,nvc.*
FROM scalingo_invoice nvc
WHERE 1=1
--   AND nvc.id = '12336c46-e5b1-4679-afef-c56ecd9aa048'
  AND nvc.billing_month BETWEEN '2023-01-01' AND '2023-02-01'
  AND nvc._ctx = '{"connection_name": "scalingo_secnum"}'
ORDER BY nvc.billing_month DESC;


-- Build queries locally


DROP TABLE IF EXISTS scalingo_invoice;

CREATE TABLE scalingo_invoice (
    id TEXT,
    total_price INTEGER,
    billing_month DATE,
    invoice_number TEXT,
    state TEXT,
    items JSONB,
    detailed_items JSONB
);


INSERT INTO  scalingo_invoice (
    id,
    total_price,
    billing_month,
    invoice_number,
    state,
    items,
    detailed_items
 ) VALUES (
    '83ab0239-8718-498a-a21e-9b29f54bd388',
    55566,
    '2021-05-01' :: DATE,
    '2021-11-21367',
    'new',
    '[{"id": "7f244d33-4cd4-4460-b116-8871387f4ecd", "label": "Platform Consumption - Region osc-fr1", "price": 55566}]',
    '[
  {
    "id": "9a0f92f2-2d00-446d-9133-c785d4e73441",
    "app": "pix-api-review-pr3671",
    "label": "Addon PostgreSQL - Sandbox",
    "price": 0
  },
  {
    "id": "c9b8489a-3221-4f5a-a339-321b2e1e4f1a",
    "app": "pix-api-review-pr3671",
    "label": "Addon Redis - Sandbox",
    "price": 0
  },
  {
    "id": "a0e47cf2-0817-4f34-94b0-bc8262b0cbc8",
    "app": "pix-api-review-pr3671",
    "label": "Containers - type: web - size: S",
    "price": 1
  }]'
);
INSERT INTO  scalingo_invoice (
    id,
    total_price,
    billing_month,
    invoice_number,
    state,
    items,
    detailed_items
 ) VALUES (
    '83ab0239-8718-498a-a21e-9b29f54bd389',
    55566,
    '2021-06-01' :: DATE,
    '2021-11-21367',
    'new',
    '[{"id": "7f244d33-4cd4-4460-b116-8871387f4ecf", "label": "Platform Consumption - Region osc-fr1", "price": 55566}]',
    '[
  {
    "id": "9a0f92f2-2d00-446d-9133-c785d4e73441",
    "app": "pix-api-review-pr3671",
    "label": "Addon PostgreSQL - Sandbox",
    "price": 0
  },
  {
    "id": "c9b8489a-3221-4f5a-a339-321b2e1e4f1a",
    "app": "pix-api-review-pr3671",
    "label": "Addon Redis - Sandbox",
    "price": 0
  },
  {
    "id": "a0e47cf2-0817-4f34-94b0-bc8262b0cbc8",
    "app": "pix-api-review-pr3671",
    "label": "Containers - type: web - size: S",
    "price": 1
  }]'
);

-- Invoice
-- Given month
SELECT
  --nvc.*,
  arr.item_object
FROM scalingo_invoice nvc,
    JSONB_ARRAY_ELEMENTS(items) WITH ORDINALITY arr (item_object, position)
WHERE 1=1
    AND nvc.billing_month BETWEEN '2021-05-01' AND '2021-06-01'
;

-- Invoice
-- Given month and region
SELECT
  --nvc.*,
  arr.item_object
FROM scalingo_invoice nvc,
    JSONB_ARRAY_ELEMENTS(items) WITH ORDINALITY arr (item_object, position)
WHERE 1=1
    AND nvc.billing_month BETWEEN '2021-05-01' AND '2021-06-01'
--     AND arr.position = 1
--     AND arr.item_object->>'label' ILIKE '%Region osc-fr1%'
--     AND arr.item_object->>'id' = '7f244d33-4cd4-4460-b116-8871387f4ecd'
--ORDER BY nvc.billing_month DESC
 LIMIT 1;

-- Invoice
-- Given id + Region
SELECT
  --nvc.*,
  arr.item_object
FROM scalingo_invoice nvc,
    JSONB_ARRAY_ELEMENTS(items) WITH ORDINALITY arr (item_object, position)
WHERE 1=1
    AND nvc.id = '83ab0239-8718-498a-a21e-9b29f54bd388'
    AND arr.position = 1
    AND arr.item_object->>'label' ILIKE '%Region osc-fr1%'
    AND arr.item_object->>'id' = '7f244d33-4cd4-4460-b116-8871387f4ecd'
--ORDER BY nvc.billing_month DESC
 LIMIT 1;

-- Invoice
-- Given id + Region + Application name + usage
SELECT
    'Invoice=>'
--      ,nvc.id
     ,nvc.invoice_number number
     ,TO_CHAR(nvc.billing_month,'YYYY-MM') as month
     ,nvc_array.item_object->>'label' region
--      ,nvc_array.item_object
     ,'Application=>'
     ,nvc_dtl_array.item_object->>'app' name
     ,nvc_dtl_array.item_object->>'label' usage
     ,'Cost=>'
     ,nvc_dtl_array.item_object->>'price' price
--      ,'detailed_items=>'
--      ,nvc_dtl_array.position line
--      ,nvc_dtl_array.item_object
FROM scalingo_invoice nvc,
    JSONB_ARRAY_ELEMENTS(items) WITH ORDINALITY nvc_array (item_object, position),
    JSONB_ARRAY_ELEMENTS(detailed_items) WITH ORDINALITY nvc_dtl_array (item_object, position)
WHERE 1=1
      AND nvc.billing_month BETWEEN '2021-05-01' AND '2021-06-01'
--     AND nvc.id = '83ab0239-8718-498a-a21e-9b29f54bd388'
   -- AND nvc_array.position = 1
     AND nvc_array.item_object->>'label' ILIKE '%Region osc-fr1%'
--     AND nvc_array.item_object->>'id' = '7f244d33-4cd4-4460-b116-8871387f4ecd'
    --AND nvc_dtl_array.position = 3
       AND nvc_dtl_array.item_object->>'app' = 'pix-api-review-pr3671'
  --     AND nvc_dtl_array.item_object->>'label' = 'Addon PostgreSQL - Sandbox'
ORDER BY nvc.billing_month ASC;
