class ProjectsController < ApplicationController
  # Index action
  def index
    role_queries = {
      'manager' => ->(user) { Project.where(manager_id: user.id) },
      'qa' => ->(user) { Project.where("assigned_to_qa @> ARRAY[?]", [user.id]) },
      'developer' => ->(user) { Project.where("assigned_to_developer @> ARRAY[?]", [user.id]) }
    }
    @projects = role_queries.fetch(current_user.role).call(current_user)    
  end

  # Show action
  def show
    @project = Project.find(params[:id])
    # @users = User.all
    @task = Task.new

    if current_user.role == 'qa'
      @assigned_developer_ids = User.where(id: @project.assigned_to_developer)
    end
    if current_user.role == 'manager' 
      @qas = User.where(role: 'qa')
      @devs = User.where(role: 'developer')
    end
    # unless @project.manager_id == current_user.id
      # redirect_to root_path, alert: "Access denied. You are not assigned to this project."
    # end
  end

  # New action
  def new
    @project = Project.new
  end

  # Create action
  def create
    @project = Project.new(project_params)
    authorize @project
    @project.manager_id = current_user.id

    if @project.save
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Edit action
  def edit
    @project = Project.find(params[:id])
  end

  # Update action
  def update
    @project = Project.find(params[:id])
    if params[:project][:assigned_to_qa] && params[:project][:assigned_to_developer]
        qa_ids_as_integers = params[:project][:assigned_to_qa].map(&:to_i)
        qa_ids_as_integers -= @project.assigned_to_qa
        @project.assigned_to_qa += qa_ids_as_integers
        dev_ids_as_integers = params[:project][:assigned_to_developer].map(&:to_i)
        dev_ids_as_integers -= @project.assigned_to_developer
        @project.assigned_to_developer += dev_ids_as_integers
        @project.save!
        # emails
        qas = User.where(id: qa_ids_as_integers)
        # @qa_emails = qas.pluck(:email)
        devs = User.where(id: dev_ids_as_integers)
        # @dev_emails = devs.pluck(:email)
        users = qas+devs
        users.each do |user|
          SignUpEmailMailer.projectAssignedNotification(@project,user).deliver_now
        end
        redirect_to @project, notice: "Project Assigned Successfully"
    elsif @project.update(project_params)
        redirect_to @project, notice: "Project updated successfully"
    else
        render :edit_project, status: :unprocessable_entity
    end
  end

  # Delete action
  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def project_params
    # Strong params
    params.require(:project).permit(:name, :description, assigned_to_qa: [], assigned_to_developer: [])
  end
end
