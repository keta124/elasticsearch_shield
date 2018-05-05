class AddFieldsToSmsLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :sms_logs, :user_id, :integer
    add_index :sms_logs, :user_id
  end
end
