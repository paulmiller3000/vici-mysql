SELECT 	
	DATE(vdl.call_date) AS call_date
	, DATE_FORMAT(vdl.call_date,'%H:%i:%s') AS call_time
	, CONCAT( "(", LEFT(vdl.extension,3), ") " , MID(vdl.extension,4,3) , "-" , RIGHT(vdl.extension,4)) AS DID	
	, CONCAT( "(", LEFT((RIGHT(vdl.caller_id_number, 10)),3) , ") " , mid((RIGHT(vdl.caller_id_number, 10)),4,3) , "-", RIGHT((RIGHT(vdl.caller_id_number, 10)),4)) AS caller_phone	
	, SEC_TO_TIME(length_in_sec) AS call_duration
	, vcl.status		
	, u.full_name AS agent_name
FROM 
	vicidial_closer_log as vcl	 
LEFT JOIN
	vicidial_did_log AS vdl ON
		vcl.uniqueid = vdl.uniqueid
LEFT JOIN
	vicidial_users AS u ON
		vcl.user = u.user
WHERE 
	vdl.extension IN('8005551234','18005551234') 
	AND vdl.call_date BETWEEN '2018-07-09 00:00:00' AND '2018-07-10 23:59:59'
ORDER BY
	vdl.call_date
	, vdl.caller_id_number
LIMIT 100000