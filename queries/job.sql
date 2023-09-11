-- Job
SELECT
	name, 
	state, 
	data, 
	completedon, 
	output 
FROM pgboss.job jb 
WHERE 1=1
	AND name = 'ParticipationResultCalculationJob' 
	AND completedon IS NOT NULL 
	AND state='failed' 
ORDER BY 
	"completedon" DESC 
LIMIT 2
;

