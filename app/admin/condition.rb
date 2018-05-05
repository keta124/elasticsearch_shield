ActiveAdmin.register Condition do

  index do
    selectable_column
    id_column
    column :user
    column :number_of_days
    column :percent_changed
    column :last_notified_at
  end

end
