

SET @callDateStart = '2018-08-18 00:00:00';
SET @callDateEnd = '2018-08-18 23:59:59';

/* List of callers to Campaign 1000 */
SELECT
	campaign_id
	, length_in_sec
	, status
	, phone_number
	, user_group
	, queue_seconds
	, user
	, CASE status
		WHEN 'DROP' THEN length_in_sec
		ELSE length_in_sec - queue_seconds
	  END AS lengthInSeconds
FROM
	vicidial_closer_log
WHERE
	call_date BETWEEN @callDateStart AND @callDateEnd
AND campaign_id IN(1000)
AND phone_number IN(0197626262)
LIMIT 10000000;


/* Total Calls */
SELECT
	COUNT(campaign_id) AS TotalCalls
FROM
	vicidial_closer_log
WHERE
	call_date BETWEEN @callDateStart AND @callDateEnd
AND
	campaign_id IN(1000)
LIMIT 10000000;


/* Unique callers */
SELECT
	COUNT(DISTINCT phone_number) AS UniqueCount
FROM vicidial_closer_log
WHERE
	call_date BETWEEN @callDateStart AND @callDateEnd
AND campaign_id IN(1000);


/* Duplicate callers - Sum */
SELECT COUNT(a.phone_number) AS DuplicatesSameDay
FROM (
	SELECT
		phone_number
		, COUNT(phone_number) AS DupesSameDay
	FROM vicidial_closer_log
	WHERE
		call_date BETWEEN @callDateStart AND @callDateEnd
	AND campaign_id IN(1000)
	GROUP BY
		phone_number
	HAVING
		COUNT(phone_number) > 1
	ORDER BY
		phone_number) AS a;


/* Duplicate callers - Detail */
SELECT
	phone_number
	, COUNT(phone_number) AS num_calls
FROM vicidial_closer_log
WHERE
	call_date BETWEEN @callDateStart AND @callDateEnd
AND campaign_id IN(1000)
GROUP BY
	phone_number
HAVING
	COUNT(phone_number) > 1
ORDER BY
	phone_number;