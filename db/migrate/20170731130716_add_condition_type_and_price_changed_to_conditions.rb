class AddConditionTypeAndPriceChangedToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :condition_type, :integer, null: false, default: 0
    add_index :conditions, :condition_type
    add_column :conditions, :price_changed, :decimal
    change_column :conditions, :percent_changed, :decimal, null: true
  end
end
