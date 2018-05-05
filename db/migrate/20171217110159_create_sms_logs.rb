class CreateSmsLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_logs do |t|
      t.string :provider
      t.string :status
      t.string :to_number
      t.string :content

      t.timestamps
    end
  end
end
