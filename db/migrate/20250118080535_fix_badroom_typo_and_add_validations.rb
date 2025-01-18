class FixBadroomTypoAndAddValidations < ActiveRecord::Migration[7.1]
  def change
    # Fix the typo in the column name
    rename_column :apartments, :badroom, :bedroom
    
    # Add not null constraints
    change_column_null :apartments, :bedroom, false
    change_column_null :apartments, :apt_type, false
    change_column_null :apartments, :condition, false
    change_column_null :apartments, :price, false
    change_column_null :apartments, :location, false
    change_column_null :apartments, :user_id, false
    
    # Add foreign key constraint
    add_foreign_key :apartments, :users
    
    # Add default values where appropriate
    change_column_default :apartments, :condition, "good"
    
    # Add price validation (ensure it's positive)
    execute "ALTER TABLE apartments ADD CONSTRAINT check_price_positive CHECK (price > 0)"
  end
end
