class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.timestamps null: false
    end
    add_reference :hotels, :guest, foreign_key: true
  end
end
