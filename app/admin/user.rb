ActiveAdmin.register User do
  permit_params :email, :phone, :credits

  index do
    selectable_column
    id_column
    column :email
    column :phone
    column :credits
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :phone
      f.input :credits
    end
    f.actions
  end

end
