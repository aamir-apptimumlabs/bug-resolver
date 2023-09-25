class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  # enum :status [:new, :started, :completed]
  # enum :typed [:feature, :bug]
  enum status: ['created_now', 'started', 'completed']
  enum task_type: ['feature', 'bug']

  validates :title, presence: true
  validates :status, presence: true
  validates :task_type, presence: true
end

