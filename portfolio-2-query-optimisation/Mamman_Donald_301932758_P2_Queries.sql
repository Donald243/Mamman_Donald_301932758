-- Show related reservation, guest, room records (up to 20).
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."confirmation_code" AS "reservation_confirmation_code",
       t1."guest_id" AS "guest_guest_id",
       t1."email" AS "guest_email",
       t2."room_id" AS "room_room_id",
       t2."room_number" AS "room_room_number"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."room" t2 ON t0."room_id" = t2."room_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."confirmation_code" AS "reservation_confirmation_code",
       t1."guest_id" AS "guest_guest_id",
       t1."email" AS "guest_email",
       t2."room_id" AS "room_room_id",
       t2."room_number" AS "room_room_number"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."room" t2 ON t0."room_id" = t2."room_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id"
LIMIT 20;

-- Find guest records where email matches "alex.park@example.test" (up to 20).
SELECT * FROM portfolio."guest"
WHERE "email" IS NOT DISTINCT FROM 'alex.park@example.test'
ORDER BY "guest_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."guest"
WHERE "email" IS NOT DISTINCT FROM 'alex.park@example.test'
ORDER BY "guest_id"
LIMIT 20;

-- Count reservation records for each guest_id (up to 20 groups).
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
