SELECT *
FROM challenges chl
WHERE 1=1
    AND chl.id = 'recig28tbjrFTKhsJ'
;


-- Challenges + Skills + Tubes + Competences
SELECT
    chl.id "challengeId",
    --skl.id "skillId",
    skl.name,
    --tb.id "tubeId",
    cpt.id "competenceId"
FROM challenges chl
    INNER JOIN skills skl ON skl.id = chl."skillId"
    INNER JOIN tubes tb ON tb.id = skl."tubeId"
    INNER JOIN competences cpt ON cpt.id = tb."competenceId"
WHERE 1=1
    --AND chl.id = 'recig28tbjrFTKhsJ'
    AND chl.id IN ( 'recig28tbjrFTKhsJ', 'recr5sU9yzh4rLy3N', 'challenge1TJ9i3EE7NNPYW', 'challenge2qYztCM8xtigga', 'challenge1Mquvze6frG90N',
                    'recmN4xkduYcoOMXb', 'challenge2HngGbF3E5wNoy', 'recPycNr5B6CUBtVC', 'challenge18PCtKXnSXsqTA', 'challenge2UiNE4jZcFBWVn',
                     'challenge2BvWMWHTvpxvVE', 'recuypGlqSqhvmYFV', 'challengeSxDbh3EwHFhtE', 'rec2NdgGnQTNHdYXi', 'rec2FGYJ1ttvHxe66')
;