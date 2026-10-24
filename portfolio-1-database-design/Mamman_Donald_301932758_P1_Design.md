# Hotel Reservation System — database design

My case study records guest, room, reservation.

## Users

- Guests who book rooms
- Hotel staff who manage rooms and reservations

## Main operations

- Create and review reservations
- Find available room options for a date range
- Summarize reservations and revenue by room type

## Entities

| Entity | Information stored |
| --- | --- |
| guest | Stores the contact details of a person who makes reservations. |
| room | Stores a hotel's bookable room details and nightly rate. |
| reservation | Records a guest's reservation of a room for a date range. |

## guest

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| email | TEXT | Unique | Yes |
| full_name | TEXT |  | Yes |
| phone | TEXT |  | No |
- Unique key: (email).

## room

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| room_id | BIGINT | PK | Yes |
| room_number | TEXT | Unique | Yes |
| room_type | TEXT |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| capacity | INTEGER |  | Yes |
| is_active | BOOLEAN |  | Yes |
- Unique key: (room_number).

## reservation

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| confirmation_code | TEXT | Unique | Yes |
| guest_id | BIGINT | FK | Yes |
| room_id | BIGINT | FK | Yes |
| check_in | DATE |  | Yes |
| check_out | DATE |  | Yes |
| status | TEXT |  | Yes |
| total_amount | NUMERIC(18,2) |  | Yes |
- guest_id → guest.guest_id
- room_id → room.room_id
- Unique key: (confirmation_code).

## Relationships and business rules

- Each guest email identifies at most one guest.
- Each room number identifies at most one room.
- Each confirmation code identifies at most one reservation, including when concurrent inserts use the same code.
- Every reservation must reference an existing guest.
- Every reservation must reference an existing room.
- Check-out must be later than check-in.
- Reservation status must be pending, confirmed, cancelled, checked_in, or checked_out.
- A room's nightly rate must be greater than zero.

## Assumptions

- Each reservation is for exactly one guest and one room.
- Check-out must be later than check-in; this model does not encode partial-night pricing.
- Room availability across overlapping date ranges is outside the constraints of this small exercise.
- Confirmation codes and room numbers are unique, and identifiers are globally unique across tables.
- Reservation status is limited to pending, confirmed, cancelled, checked_in, or checked_out.

