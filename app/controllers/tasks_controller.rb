class TasksController < ApplicationController
  def index 
    @users = User.all
  end
  
  def new
    @project = Project.find_by_id(params[:project_id])
    @task = @project.tasks.build
  end
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      if current_user.role == 'manager'
        redirect_to project_path(@project)
      elsif current_user.role == 'qa'
       redirect_to qa_show_path(@project)
      end
    else 
      render :new, status: :unprocessable_entity
    end
  end
    # update
    def edit
      @project = Project.find(params[:project_id])
      @task = Task.find_by_id(params[:id])
      # debugger
      # @task = @project.tasks
    end
  
    def update
      # binding.pry
      @task = Task.find(params[:id])
      # developer_id = params[:task][:developer_id]
  
      if @task.present?
        @task.update(task_params)
        flash[:success] = "Developer assigned to the task."
      else
        flash[:error] = "Please select a developer."
      end
      if (current_user.role == 'qa')
        project = Project.find(params[:project_id])
        redirect_to qa_show_path(project)
      elsif (current_user.role == 'developer')
        redirect_to developer_dashboard_path
      end
    end
  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      if current_user.role == 'qa'
        redirect_to qa_show_path(@project)
      else
        redirect_to project_path(@project), status: :see_other
      end
    end
  end

  def assign_developer
    @task = Task.find(params[:task_id])
    developer_id = params[:task][:developer_id]

    if developer_id.present?
      @task.update(developer_id: developer_id)
      flash[:success] = "Developer assigned to the task."
    else
      flash[:error] = "Please select a developer."
    end
    redirect_to @task.project
  end
  private
    def task_params
      params.require(:task).permit(:title, :description, :timeline, :status, :task_type, :user_id, :project_id, :developer_id, :qa_id)
    end
end

