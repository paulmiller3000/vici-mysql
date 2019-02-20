/* Returns a list of phone numbers that dialed after hours, excluding certain types of callers */

SET @callDateStart = '2018-09-04 00:00:00';
SET @callDateEnd = '2018-09-04 23:59:59';

SELECT
	DISTINCT phone_number
FROM
	vicidial_closer_log
WHERE call_date BETWEEN @callDateStart AND @callDateEnd 
AND status IN('AFTHRS','DROP')
AND (
	campaign_id IN('1001','1002','1003')  
	OR user_group = 'CustomerService' 
	)
AND phone_number NOT IN (
	SELECT
		phone_number
	FROM
		vicidial_closer_log
	WHERE call_date BETWEEN @callDateStart AND @callDateEnd 
	AND (
		campaign_id IN('1001','1002','1003')  
		OR user_group = 'CustomerService' 
		)
	AND status IN('CXL','DNC','HungUp','INCALL','N','NI','NP','Refund','SALE','SavedS')
)
ORDER BY 
	phone_number