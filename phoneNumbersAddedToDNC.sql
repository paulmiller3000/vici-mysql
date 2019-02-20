SET @start_date = '2018-07-10 00:00:00';
SET @end_date = '2018-07-10 23:59:59';

SELECT 	
	CONCAT( "(", LEFT(d.phone_number,3), ") " , MID(d.phone_number,4,3) , "-" , RIGHT(d.phone_number,4)) AS DID	
	, DATE(d.action_date) AS dnc_add_date
	, DATE_FORMAT(d.action_date,'%H:%i:%s') AS dnc_add_time
	, u.full_name AS agent_name
FROM 
	vicidial_dnc_log AS d
LEFT JOIN
	vicidial_users AS u ON
		d.user = u.user
WHERE
	d.action_date BETWEEN @start_date AND @end_date
ORDER BY
	d.action_date
	, d.phone_number
LIMIT
	1000