ActiveAdmin.register User do

  permit_params do
    permitted = User.attribute_names.reject {|field| field == 'id' }
    permitted
  end

   index do
    column :id
    column :ranking
    column :visits
    column :name
    column :email
    column :uid
    column :city_name
    column :homepage
    column :company
    actions
  end

end
