class ChangesToConditions < ActiveRecord::Migration[5.1]
  def change
    remove_column :conditions, :number_of_days, :integer
    remove_column :conditions, :percent_changed, :decimal
    remove_column :conditions, :condition_type, :integer
    remove_column :conditions, :price_changed, :decimal

    add_column :conditions, :coin, :string
    add_column :conditions, :currency, :string
    add_column :conditions, :value, :decimal, precision: 20, scale: 10
    add_column :conditions, :operation, :integer
    add_column :conditions, :active, :boolean, default: true
  end
end
