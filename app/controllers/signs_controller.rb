# app/controllers/registrations_controller.rb
class SignsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
  end

  def after_sign_up_path_for(resource)
    # case resource.role
    # when 'developer'
    #   developer_dashboard_path
    # when 'qa'
    #   qa_dashboard_path
    # else
      root_path
    # end
  end
end