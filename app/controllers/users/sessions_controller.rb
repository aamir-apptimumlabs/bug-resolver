class Users::SessionsController < Devise::SessionsController
  before_action :check_user_approval, only: :create

  def check_user_approval
    user = User.find_by(email: params[:user][:email])

    if user.present? && !user.approved?
      flash[:notice] = "Your account has not been approved yet."
      redirect_to new_user_session_path
    end
  end
end
