class TasksController < ApplicationController
  def create
    # binding.pry
    @project = Project.find(params[:project_id])
    
    @task = @project.tasks.create(task_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project), status: :see_other
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :timeline, :status, :task_type)
    end
end

