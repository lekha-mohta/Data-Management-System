class BuildProjectsController < ApplicationController
  before_action :set_build_project, only: %i[show edit update destroy]

  # GET /build_projects
  def index
    if current_user.get_role_number != 3
      redirect_to root_path, alert: 'You are not allowed to visit this page.' and return
    end

    @build_projects = BuildProject.all
  end

  # GET /build_projects/1
  def show; end

  # GET /build_projects/new
  def new
    @build_project = BuildProject.new
  end

  # GET /build_projects/1/edit
  def edit
    return unless current_user.get_role_number != 3

    redirect_to root_path, alert: 'You are not allowed to visit this page.' and return
  end

  # POST /build_projects
  def create
    @build_project = BuildProject.new(build_project_params)

    if @build_project.save
      redirect_to builds_path, notice: 'Build project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /build_projects/1
  def update
    if current_user.get_role_number != 3
      redirect_to root_path, alert: 'You are not allowed to visit this page.' and return
    end

    if @build_project.update(build_project_params)
      redirect_to @build_project, notice: 'Build project was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /build_projects/1
  def destroy
    if current_user.get_role_number != 3
      redirect_to root_path, alert: 'You are not allowed to visit this page.' and return
    end

    @build_project.destroy
    redirect_to build_projects_url, notice: 'Build project was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_build_project
    @build_project = BuildProject.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def build_project_params
    params.require(:build_project).permit(:name, :description)
  end
end
