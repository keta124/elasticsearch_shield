class AddSourceToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :source, :integer, null: false, default: 0
    add_index :conditions, :source
  end
end
