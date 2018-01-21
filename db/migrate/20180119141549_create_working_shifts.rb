class CreateWorkingShifts < ActiveRecord::Migration
  def change
    create_table :working_shifts do |t|
      t.string :start_time
      t.string :end_time
      t.string :shift_type
      t.timestamps null: false
    end
    add_reference :working_shifts, :hotel, foreign_key: true
  end
end
