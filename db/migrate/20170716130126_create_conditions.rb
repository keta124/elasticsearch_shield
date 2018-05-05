class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.integer :user_id, null: false
      t.integer :number_of_days, null: false
      t.decimal :percent_changed, null: false

      t.timestamps
    end
    add_index :conditions, :user_id
  end
end
