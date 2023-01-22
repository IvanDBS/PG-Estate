class CreateApartments < ActiveRecord::Migration[7.0]
  def change
    create_table :apartments do |t|
      t.integer :badroom
      t.string :apt_type
      t.string :condition
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
