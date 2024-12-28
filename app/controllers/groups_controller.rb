class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  authorize_resource

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/1
  def show
    @users = @group.get_group_users
    @materials = @group.get_group_materials
    @cads = @group.get_group_cads
    @builds = @group.get_group_builds
    @machines = @group.get_group_machines
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @users = @group.get_group_users
    @materials = @group.get_group_materials
    @cads = @group.get_group_cads
    @builds = @group.get_group_builds
    @machines = @group.get_group_machines
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    if @group.name == 'Confidential' || @group.name == 'Commercially Available'
      redirect_to groups_url, notice: 'This group cannot be deleted.', status: :forbidden
    else
      @group.destroy
      redirect_to groups_url, notice: 'Group was successfully destroyed.', status: :see_other
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :description)
  end

  # In your controller
  def add_material
    @group = Group.find(params[:group_id])
    @group.materials << Material.find(params[:material_id])
    redirect_to edit_group_path(@group)
  end
end
