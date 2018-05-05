class AddIndexToExchangeCoins < ActiveRecord::Migration[5.1]
  def change
    add_index :exchange_coins, [ :market, :coin ]
  end
end
