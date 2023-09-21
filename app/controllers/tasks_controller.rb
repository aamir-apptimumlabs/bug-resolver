class TasksController < ApplicationController
  def index 
    @users = User.all
  end
  def create
    # binding.pry
    @project = Project.find(params[:project_id])

    # # assign qa
    # binding.pry
    # qa_id = params[:qa_id] || []
    # binding.pry
    @task = @project.tasks.create(task_params)
    redirect_to project_path(@project)

  end

    # update
    def edit
      @project = Project.find(params[:id])
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
  
      redirect_to qa_dashboard_path
    end
  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project), status: :see_other
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
      params.require(:task).permit(:title, :description, :timeline, :status, :task_type, :user_id, :project_id, :developer_id)
    end
end

