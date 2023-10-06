require "test_helper"

class SignUpEmailMailerTest < ActionMailer::TestCase
  test "signUpNotification" do
    mail = SignUpEmailMailer.signUpNotification
    assert_equal "Signupnotification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
