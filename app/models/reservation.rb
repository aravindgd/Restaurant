class Reservation < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :guest
  belongs_to :hotel_seat
end
