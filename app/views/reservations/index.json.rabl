
collection @reservations
node (:guest) {|g| g.guest.name}
node (:reservation_time) {|reservation| reservation.booking_day}
node (:guest_count) {|reservation| reservation.guest_count}
node (:table_name) {|reservation| reservation.hotel_seat.name}

