class ApplicationController < ActionController::Base
  # Include error handling module
  include Error::ErrorHandler

  # Include Pundit for authorization
  include Pundit

  # Ensure authentication for all actions
  before_action :authenticate_user!

  # Determine the redirect path after user signs in
  def after_sign_in_path_for(resource)
      root_path
  end
end
