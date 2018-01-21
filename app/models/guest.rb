class Guest < ActiveRecord::Base
  
  has_many :hotels
  has_many :reservations, through: :hotels
  has_many :hotel_seats, through: :hotels
  validates_presence_of :name, :email

end
