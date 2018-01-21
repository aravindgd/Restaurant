class CreateHotelSeats < ActiveRecord::Migration
  def change
    create_table :hotel_seats do |t|
      t.string :name
      t.integer :minimum_seats
      t.integer :maximum_seats
      t.timestamps null: false
    end
    add_reference :hotel_seats, :hotel, foreign_key: true
  end
end
