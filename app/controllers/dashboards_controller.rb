class DashboardsController < ApplicationController
    before_action :authenticate_user!
  
    def qa_projects
      restrict_to_qa!
      @projects = Project.where("assigned_to_qa @> ARRAY[?]", [current_user.id])
    end
    
    def qa
      restrict_to_qa!
      @users = User.all
      @tasks = Task.where(qa_id: current_user.id)
    end

    def qa_new
      restrict_to_qa!
      @project = Project.find(params[:project_id])
      @task = Task.new
    end

    def qa_create
      restrict_to_qa!
    end

    def qa_show
      restrict_to_qa!
      @users = User.all
      @project = Project.find(params[:project_id])
      # 
      unless @project.assigned_to_qa.include?(current_user.id)
        redirect_to root_path, alert: "Access denied. You are not assigned to this project."
      end
    end
  
    def developer
      restrict_to_developer!
      @tasks = Task.where(developer_id: current_user.id)
      # @projects = current_user.projects.joins(:tasks).where(tasks: { task_type: 'developer' }).distinct
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
  