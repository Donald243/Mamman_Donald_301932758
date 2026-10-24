-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. guest pk duplicate. Expected: pk_guest, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone")
VALUES (1001, 'pk-test@example.test', 'PK Test', NULL);

-- 2. guest unique duplicate. Expected: uq_guest_0, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone")
VALUES (4102, 'alex.park@example.test', 'Unique Test', NULL);

-- 3. guest id not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone")
VALUES (NULL, 'guest-id-test@example.test', 'ID Test', NULL);

-- 4. guest email not null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone")
VALUES (4104, NULL, 'Email Test', NULL);

-- 5. guest name not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "email", "full_name", "phone")
VALUES (4105, 'guest-name-test@example.test', NULL, NULL);

-- 6. room pk duplicate. Expected: pk_room, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (2001, 'PK-TEST', 'standard', 100, 1, TRUE);

-- 7. room unique duplicate. Expected: uq_room_0, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4202, '101', 'suite', 200, 2, TRUE);

-- 8. room id not null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (NULL, 'NN-ROOM-ID', 'standard', 100, 1, TRUE);

-- 9. room number not null. Expected: room_number, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4204, NULL, 'standard', 100, 1, TRUE);

-- 10. room type not null. Expected: room_type, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4205, 'NN-ROOM-TYPE', NULL, 100, 1, TRUE);

-- 11. room rate not null. Expected: nightly_rate, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4206, 'NN-ROOM-RATE', 'standard', NULL, 1, TRUE);

-- 12. room capacity not null. Expected: capacity, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4207, 'NN-ROOM-CAP', 'standard', 100, NULL, TRUE);

-- 13. room active not null. Expected: is_active, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4208, 'NN-ROOM-ACTIVE', 'standard', 100, 1, NULL);

-- 14. room rate check. Expected: room_rate_positive, SQLSTATE 23514.
INSERT INTO portfolio."room" ("room_id", "room_number", "room_type", "nightly_rate", "capacity", "is_active")
VALUES (4209, 'BAD-RATE', 'standard', 0, 1, TRUE);

-- 15. reservation pk duplicate. Expected: pk_reservation, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (3001, 'PK-RES-TEST', 1001, 2001, '2026-12-01', '2026-12-03', 'pending', 200);

-- 16. reservation unique duplicate. Expected: uq_reservation_0, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4302, 'CONF-A100', 1001, 2001, '2026-12-04', '2026-12-06', 'pending', 200);

-- 17. reservation guest fk. Expected: fk_reservation_0, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4303, 'FK-GUEST-TEST', 990001, 2001, '2026-12-07', '2026-12-09', 'pending', 200);

-- 18. reservation room fk. Expected: fk_reservation_1, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4304, 'FK-ROOM-TEST', 1001, 990002, '2026-12-10', '2026-12-12', 'pending', 200);

-- 19. reservation id not null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (NULL, 'NN-RES-ID', 1001, 2001, '2026-12-13', '2026-12-15', 'pending', 200);

-- 20. reservation code not null. Expected: confirmation_code, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4306, NULL, 1001, 2001, '2026-12-16', '2026-12-18', 'pending', 200);

-- 21. reservation guest not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4307, 'NN-GUEST-ID', NULL, 2001, '2026-12-19', '2026-12-21', 'pending', 200);

-- 22. reservation room not null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4308, 'NN-ROOM-ID', 1001, NULL, '2026-12-22', '2026-12-24', 'pending', 200);

-- 23. reservation checkin not null. Expected: check_in, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4309, 'NN-CHECK-IN', 1001, 2001, NULL, '2026-12-27', 'pending', 200);

-- 24. reservation checkout not null. Expected: check_out, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4310, 'NN-CHECK-OUT', 1001, 2001, '2026-12-28', NULL, 'pending', 200);

-- 25. reservation status not null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4311, 'NN-STATUS', 1001, 2001, '2026-12-29', '2026-12-31', NULL, 200);

-- 26. reservation amount not null. Expected: total_amount, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4312, 'NN-AMOUNT', 1001, 2001, '2027-01-01', '2027-01-03', 'pending', NULL);

-- 27. reservation dates check. Expected: reservation_dates_valid, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4313, 'BAD-DATES', 1001, 2001, '2027-01-05', '2027-01-04', 'pending', 200);

-- 28. reservation status check. Expected: reservation_status_valid, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4314, 'BAD-STATUS', 1001, 2001, '2027-01-06', '2027-01-08', 'reserved', 200);
