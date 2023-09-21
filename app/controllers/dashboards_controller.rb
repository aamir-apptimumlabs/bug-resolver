class DashboardsController < ApplicationController
    before_action :authenticate_user!
  
    def qa
      restrict_to_qa!
      @users = User.all
      @tasks = Task.where(qa_id: current_user.id)
      # @project = Project.find(@tasks[1].project_id)
      # @project = Project.first
      @projects = current_user.projects.joins(:tasks).where(tasks: {qa_id: current_user.id}).distinct
    end
  
    def developer
      restrict_to_developer!
      @tasks = Task.where(developer_id: current_user.id)
      @projects = current_user.projects.joins(:tasks).where(tasks: { task_type: 'developer' }).distinct
    end


    private
    def restrict_to_developer!
      unless current_user.role == 'developer'
        redirect_to root_path, alert: "Access denied. You are not a developer."
      end
    end

    def restrict_to_qa!
      unless current_user.role == 'qa'
        redirect_to root_path, alert: "Access denied. You are not a QA."
      end
    end
  end
  