class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tasks
  has_many :projects, through: :tasks

  enum role: ['manager', 'developer', 'qa']

  after_create :send_signUp_email

  def send_signUp_email
    SignUpEmailMailer.signUpNotification(self).deliver_now
  end
end