class Task < ApplicationRecord
  belongs_to :users
  belongs_to :project
  
  enum :status ['new', 'started', 'completed']
  enum :type ['feature', 'bug']
end
