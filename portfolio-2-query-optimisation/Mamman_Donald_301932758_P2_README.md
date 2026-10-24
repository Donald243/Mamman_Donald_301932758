# Hotel Reservation System — SQL queries

## 1. Show related reservation, guest, room records (up to 20).

```sql
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
```

| reservation_reservation_id | reservation_confirmation_code | guest_guest_id | guest_email | room_room_id | room_room_number |
| --- | --- | --- | --- | --- | --- |
| 3001 | CONF-A100 | 1001 | alex.park@example.test | 2001 | 101 |

## 2. Find guest records where email matches "alex.park@example.test" (up to 20).

```sql
SELECT * FROM portfolio."guest"
WHERE "email" IS NOT DISTINCT FROM 'alex.park@example.test'
ORDER BY "guest_id"
LIMIT 20;
```

| guest_id | email | full_name | phone |
| --- | --- | --- | --- |
| 1001 | alex.park@example.test | Alex Park | +1-555-0101 |

## 3. Count reservation records for each guest_id (up to 20 groups).

```sql
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
```

| guest_id | record_count |
| --- | --- |
| 1001 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.13 | 1.13, 1.139, 1.12 | Sort → Seq Scan | 131 |
| After index | 0.186 | 0.197, 0.185, 0.186 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 1.13 ms to 0.186 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.104..1.106 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.016..1.069 rows=20 loops=1)
Planning Time: 0.387 ms
Execution Time: 1.13 ms
```

### Before index, run 2

```text
Sort (actual time=1.112..1.114 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.017..1.077 rows=20 loops=1)
Planning Time: 0.394 ms
Execution Time: 1.139 ms
```

### Before index, run 3

```text
Sort (actual time=1.094..1.096 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.016..1.061 rows=20 loops=1)
Planning Time: 0.371 ms
Execution Time: 1.12 ms
```

### After index, run 1

```text
Sort (actual time=0.154..0.156 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.03..0.099 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.017 rows=20 loops=1)
Planning Time: 0.581 ms
Execution Time: 0.197 ms
```

### After index, run 2

```text
Sort (actual time=0.137..0.139 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.03..0.101 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.017 rows=20 loops=1)
Planning Time: 0.592 ms
Execution Time: 0.185 ms
```

### After index, run 3

```text
Sort (actual time=0.139..0.141 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.03..0.104 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.017..0.017 rows=20 loops=1)
Planning Time: 0.614 ms
Execution Time: 0.186 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Mamman_Donald_301932758_P2_Queries.sql, then Mamman_Donald_301932758_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Mamman_Donald_301932758_P2_QueryResults.png) · [Index comparison](screenshots/Mamman_Donald_301932758_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

