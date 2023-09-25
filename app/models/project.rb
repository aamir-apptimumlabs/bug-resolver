class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :tasks, dependent: :destroy
  has_many :users, through: :tasks

  validates :name, presence: true
end
