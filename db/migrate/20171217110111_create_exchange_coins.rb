class CreateExchangeCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_coins do |t|
      t.string :market
      t.string :coin
      t.decimal  :price_btc, precision: 20, scale: 10
      t.decimal :price_usd, precision: 20, scale: 10
      t.decimal :price_vnd, precision: 20, scale: 10

      t.timestamps
    end
  end
end
