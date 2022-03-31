SELECT * FROM "certification-cpf-countries"
 WHERE code IN (75056, 69123, 13055)
;


SELECT
     'cities'
    ,cts.id
    ,cts."INSEECode"
    ,'certification-cpf-cities=>'
    ,cts.*
 FROM "certification-cpf-cities" cts
 WHERE 1=1
    AND cts.name ILIKE '%PARIS%'
    AND cts."INSEECode" = '75056'
    AND "INSEECode" IN ('75056', '69123', '13055')
;
