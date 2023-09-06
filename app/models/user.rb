class User < ApplicationRecord
    has_many :projects
    has_many :tasks, through: :projects

    enum role: ['manager', 'developer', 'qa']
end