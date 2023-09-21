class ApplicationController < ActionController::Base
    include Pundit
    before_action :authenticate_user!
    
  def after_sign_in_path_for(resource)
    case resource.role
    when 'developer'
      developer_dashboard_path
    when 'qa'
      qa_dashboard_path
    else
      root_path
    end
  end
end
