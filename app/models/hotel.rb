class Hotel < ActiveRecord::Base
  
  PHONE_REGEX = /\A((\+)?[1-9]{1,2})?([-\s\.])?((\(\d{1,4}\))|\d{1,4})(([-\s\.])?[0-9]{1,12}){1,2}\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  belongs_to :guest
  has_many :hotel_seats
  has_many :reservations
  has_many :working_shifts
  validates :phone, presence: true, length: { minimum: 10, maximum: 15 }
  validates_presence_of :name, :email
  validates_format_of :phone, :with => PHONE_REGEX
  validates_format_of :email, :with => VALID_EMAIL_REGEX

end
