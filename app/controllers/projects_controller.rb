class ProjectsController < ApplicationController
    def index
      @projects = Project.all
    end
    def show
      @project = Project.find(params[:id])
    end
    def new
      @project = Project.new
    end
  
    def create
      # binding.pry
      @project = Project.new(project_params)
  
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
      @project = Project.find(params[:id])
  
      if @project.update(project_params)
        redirect_to @project
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # delete
    def destroy
      @project = Project.find(params[:id])
      @project.destroy
  
      redirect_to root_path, status: :see_other
    end
  
    private
      def project_params
        # strong params
        params.require(:project).permit(:name, :description)
      end
  end
  
