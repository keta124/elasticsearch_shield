class AddPriceUsdtToExchangeCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :exchange_coins, :price_usdt, :decimal, precision: 20, scale: 10
  end
end
