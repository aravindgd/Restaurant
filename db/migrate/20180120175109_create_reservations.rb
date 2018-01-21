class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :booked_at
      t.datetime :booking_day
      t.datetime :booking_day_updated
      t.integer :guest_count_updated
      t.integer :guest_count 
      t.timestamps null: false
    end
    add_reference :reservations, :guest, foreign_key: true
    add_reference :reservations, :hotel, foreign_key: true
    add_reference :reservations, :hotel_seat, foreign_key: true
  end
end
