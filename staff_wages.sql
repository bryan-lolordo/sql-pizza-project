SELECT
	r.date,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	sh.end_time - sh.start_time AS time_difference,
    ROUND(EXTRACT(EPOCH FROM (sh.end_time - sh.start_time)) / 3600, 2) AS hours_in_shift,
	ROUND(EXTRACT(EPOCH FROM (sh.end_time - sh.start_time)) / 3600, 2) * s.hourly_rate AS staff_cost
FROM rota AS r
LEFT JOIN staff AS s ON r.staff_id = s.staff_id
LEFT JOIN shift AS sh ON r.shift_id = sh.shift_id

