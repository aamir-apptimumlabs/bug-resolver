# Preview all emails at http://localhost:3000/rails/mailers/sign_up_email_mailer
class SignUpEmailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sign_up_email_mailer/signUpNotification
  def signUpNotification
    SignUpEmailMailer.signUpNotification
  end

end
