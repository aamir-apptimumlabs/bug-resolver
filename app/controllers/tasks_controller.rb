class TasksController < ApplicationController
  before_action :find_project, only: [:new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.new(task_params)
  
    if @task.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find_by_id(params[:id])
  end

  def update
    @task = Task.find_by_id(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "Developer assigned to the task."
      redirect_to project_path(@task.project)
    else
      flash[:error] = "Please select a developer."
    end
  end

  def destroy
    debugger
    @task = @project.tasks.find(params[:id])
    debugger
    if @task.destroy
      redirect_to project_path(@project)
    end
  end

  private

  def find_project
    @project = Project.find_by_id(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :timeline, :status, :task_type, :user_id, :project_id, :developer_id, :qa_id)
  end
end
