class SignUpEmailMailer < ApplicationMailer
  default from: 'aamirsohail9210@gmail.com'

  def signUpNotification(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(
      to: @user.email, 
      subject: 'Welcome to My Awesome Site'
    )
  end

  def projectAssignedNotification(project,user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Project Assignment - #{@user.role}")
  end
end