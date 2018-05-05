class CreateCoinCalculators < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_calculators do |t|
      t.string :coin, null: false
      t.decimal :difficulty, precision: 30, scale: 10, null: false
      t.decimal :block_reward, precision: 20, scale: 10, null: false
      t.integer :type_algorithm, default: 0

      t.timestamps
    end
  end
end
