-- 1
SELECT
  booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  start_date,
  end_date,
  b.status
FROM
  bookings AS b
  JOIN users AS u ON b.user_id = u.user_id
  JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id

  -- 2
SELECT
  *
FROM
  vehicles
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      bookings
    WHERE
      bookings.vehicle_id = vehicles.vehicle_id
  )

  -- 3
SELECT
  *
FROM
  vehicles
WHERE
  status = 'available'
  AND type = 'car'
  
  -- 4
SELECT
  v.name AS vehicle_name,
  count(*) AS total_bookings
FROM
  bookings AS b
  JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id
GROUP BY
  v.name
HAVING
  count(*) >= 2