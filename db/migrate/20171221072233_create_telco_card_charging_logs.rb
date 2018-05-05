class CreateTelcoCardChargingLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :telco_card_charging_logs do |t|
      t.string :provider
      t.integer :code
      t.string :msg
      t.integer :info_card
      t.integer :transaction_id
      t.integer :user_id

      t.timestamps
    end
  end
end
