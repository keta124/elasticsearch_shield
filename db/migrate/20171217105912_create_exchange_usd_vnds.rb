class CreateExchangeUsdVnds < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_usd_vnds do |t|
      t.integer :value

      t.timestamps
    end
  end
end
