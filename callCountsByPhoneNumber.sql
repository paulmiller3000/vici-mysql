SELECT
	phone_number
	, campaign_id
	, COUNT(phone_number) AS CallCount
FROM 
	(SELECT
	phone_number
	, campaign_id
	FROM 
		vicidial_closer_log 
	WHERE
		call_date BETWEEN '2018-06-01 00:00:00' AND '2018-06-01 23:59:59'
		AND length_in_sec < 30
	LIMIT
		1000000) AS a
GROUP BY
	phone_number
	, campaign_id
HAVING
	CallCount > 5
ORDER BY
	CallCount DESC