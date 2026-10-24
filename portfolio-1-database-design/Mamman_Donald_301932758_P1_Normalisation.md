# Hotel Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservation records (list) |
| --- | --- |
| 1001 | [3001] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservation.reservation_id | reservation.confirmation_code | reservation.guest_id | reservation.room_id | guest.guest_id | guest.email | room.room_id | room.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | CONF-A100 | 1001 | 2001 | 1001 | alex.park@example.test | 2001 | 101 |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservation_example

| reservation.reservation_id | reservation.confirmation_code | reservation.guest_id | reservation.room_id | guest.guest_id | guest.email | room.room_id | room.room_number |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | CONF-A100 | 1001 | 2001 | 1001 | alex.park@example.test | 2001 | 101 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## guest

| guest_id | email | full_name | phone |
| --- | --- | --- | --- |
| 1001 | alex.park@example.test | Alex Park | +1-555-0101 |

## room

| room_id | room_number | room_type | nightly_rate | capacity | is_active |
| --- | --- | --- | --- | --- | --- |
| 2001 | 101 | standard | 125.5 | 2 | true |

## reservation

| reservation_id | confirmation_code | guest_id | room_id | check_in | check_out | status | total_amount |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | CONF-A100 | 1001 | 2001 | 2026-11-10 | 2026-11-13 | confirmed | 376.5 |

## Dependencies

- guest: (guest_id) → email, full_name, phone
- room: (room_id) → room_number, room_type, nightly_rate, capacity, is_active
- reservation: (reservation_id) → confirmation_code, guest_id, room_id, check_in, check_out, status, total_amount

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
