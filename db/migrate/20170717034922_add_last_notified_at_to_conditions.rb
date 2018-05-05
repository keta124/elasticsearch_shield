class AddLastNotifiedAtToConditions < ActiveRecord::Migration[5.1]
  def change
    add_column :conditions, :last_notified_at, :datetime
  end
end
