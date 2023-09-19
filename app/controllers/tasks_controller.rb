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
      binding.pry
      @project = Project.find(params[:id])
    
      # Fetch task and QA ID from params
      task_id = params[:task_id]
      qa_id = params[:task][:qa_id]
    
      # Check if a QA is selected
      if qa_id.present? && qa_id != "0"
        task = @project.tasks.find(task_id)
        task.update(qa_id: qa_id)
        qa_name = User.find(qa_id).name
        flash[:notice] = "Task assigned to QA #{qa_name}"
      end
    end
  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project), status: :see_other
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :timeline, :status, :task_type, :user_id, :project_id)
    end
end

