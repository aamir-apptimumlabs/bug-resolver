class ProjectsController < ApplicationController
    
    def index
      # binding.pry
      @projects = Project.all
    end
    def show
      @project = Project.find(params[:id])
      @users = User.all

      @task = Task.new # Initialize a new task instance
    end
    def new
      @project = Project.new
    end
  
    def create
      # binding.pry
      @project = Project.new(project_params)
      authorize @project
      @project.manager_id = current_user.id
      if @project.save
        redirect_to @project
      else
        render :new, status: :unprocessable_entity
      end
    end
    # update
    def edit
      @project = Project.find(params[:id])
    end
  
    def update
      # binding.pry
      if params[:task_id]
        @task = Task.find(params[:task_id])
        
        # Fetch task and QA ID from params
        qa_id = params[:task][:qa_id]
    
        # Check if a QA is selected
        if qa_id.present? && qa_id != "0"
          @task.update(qa_id: qa_id)
          qa_name = User.find(qa_id).name
          flash[:notice] = "Task assigned to QA #{qa_name}"
        end
    
        redirect_to project_path(@task.project), notice: "Task updated successfully"
      elsif params[:id]
        @project = Project.find(params[:id])
        authorize @project

        # binding.pry
        # debugger
    
        if @project.update(project_params)
          # binding.pry
          redirect_to @project, notice: "Project updated successfully"
        else
          render :edit_project, status: :unprocessable_entity
        end
        
      end
    end
    
    
  
    # delete
    def destroy
      @project = Project.find(params[:id])
      authorize @project
      @project.destroy
  
      redirect_to root_path, status: :see_other
    end
  
    private
      def project_params
        # strong params
        params.require(:project).permit(:name, :description)
      end
  end
  
