class ProjectPolicy 
  # class Scope < ApplicationPolicy::Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def create?
      # binding.pry
      user.role == 'manager'
    end
    def update?
      user.role == 'manager'
    end
    def destroy?
      user.role == 'manager'
    end
end
