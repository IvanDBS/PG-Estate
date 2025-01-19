class AddPicturesToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :pictures, :string, array: true, default: []
  end
end
