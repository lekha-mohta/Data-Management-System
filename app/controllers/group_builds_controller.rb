class GroupBuildsController < ApplicationController
  before_action :set_group_build, only: %i[show edit update destroy]

  authorize_resource

  # GET /group_builds
  def index
    @group_builds = GroupBuild.all
  end

  # GET /group_builds/1
  def show; end

  # GET /group_builds/new
  def new
    @group = Group.find(params[:format])

    # Show all group builds at the top
    @group_builds = @group.group_builds
    @group_builds = apply_word_filter(@group_builds, :name, params[:name], group_builds: true) if params[:name].present?

    # Show remaining builds
    @builds = Build.all - @group_builds.map(&:build)
    @builds = apply_word_filter(@builds, :name, params[:name]) if params[:name].present?
  end

  # GET /group_builds/1/edit
  def edit; end

  # POST /group_builds
  def create
    @group_build = GroupBuild.new(group_build_params)
    @group = Group.find(params[:group_build][:groupId])

    if @group_build.save
      redirect_to new_group_build_path(format: @group_build.groupId), notice: 'Build was successfully added to Group.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_builds/1
  def update
    if @group_build.update(group_build_params)
      redirect_to @group_build, notice: 'Group build was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /group_builds/1
  def destroy
    @group_build.destroy
    redirect_to new_group_build_path(@group_build.group), notice: 'Build was successfully removed from Group.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_build
    @group_build = GroupBuild.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_build_params
    params.require(:group_build).permit(:groupId, :buildId)
  end

  # Applies a word filter to a collection of objects based on a specified attribute and value.
  def apply_word_filter(objects, attribute, value, group_builds: false)
    objects.select do |object|
      if group_builds
        object.build.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end
end
