class AddUserIdToApartments < ActiveRecord::Migration[7.0]
  def change
    add_column :apartments, :user_id, :integer
    add_index :apartments, :user_id
  end
end
