ActiveAdmin.register Report do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :reportable_id, :reportable_type, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:reportable_id, :reportable_type, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :reportable_id, :reportable_type, :user_id
  config.per_page = 10

end
