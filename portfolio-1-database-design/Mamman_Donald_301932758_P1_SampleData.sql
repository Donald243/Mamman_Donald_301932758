-- Fictional sample records for Hotel Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone") VALUES (1001, 'alex.park@example.test', 'Alex Park', '+1-555-0101');
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active") VALUES (2001, '101', 'standard', 125.5, 2, TRUE);
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount") VALUES (3001, 'CONF-A100', 1001, 2001, '2026-11-10', '2026-11-13', 'confirmed', 376.5);
COMMIT;
