# users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: :toggle_approval

  # Uncomment and implement the toggle_approval action
  def toggle_approval
    debugger
    user = User.find(params[:id])
    user.update(approved: !user.approved)
    redirect_to admin_users_path, notice: "User approval status has been updated."
  end

  def index
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Permission denied' unless current_user.admin?
  end
end
