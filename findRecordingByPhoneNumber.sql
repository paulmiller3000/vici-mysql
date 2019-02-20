/* By phone number */
SELECT 
	l.lead_id
	, r.filename
	, r.location
	, r.length_in_sec
	, l.phone_number
	, SUBSTRING_INDEX(SUBSTRING_INDEX(r.location, '/', 5), '/', -1)
FROM 
	vicidial_list l
LEFT JOIN 
	recording_log r
		ON l.lead_id = r.lead_id
WHERE
	status = 'SALE'
	AND entry_date >='2018-05-29 00:00:00'
	AND phone_number IN(
		'5551112222'
		,'4442223333'
	)
ORDER BY
	phone_number
	, length_in_sec DESC */

/* By file name */
SELECT 
	SUBSTRING_INDEX(SUBSTRING_INDEX(r.location, '/', 5), '/', -1) AS folder
	, l.lead_id
	, r.filename
	, r.location
	, r.length_in_sec
	, l.phone_number	
FROM 
	vicidial_list l
LEFT JOIN 
	recording_log r
		ON l.lead_id = r.lead_id
WHERE
	entry_date >='2018-05-27 00:00:00'
	AND filename IN(
		'20180529-003413_5551112222'
		,'20180529-003713_4442223333'
	)
ORDER BY
	folder
	, phone_number
	, length_in_sec DESC