class ChangeBadroomToBeStringInApartments < ActiveRecord::Migration[7.0]
  def change
     change_column :apartments, :badroom, :string
  end
end
