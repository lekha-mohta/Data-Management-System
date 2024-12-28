class GroupCadsController < ApplicationController
  before_action :set_group_cad, only: %i[show edit update destroy]

  authorize_resource

  # GET /group_cads
  def index
    @group_cads = GroupCad.all
  end

  # GET /group_cads/1
  def show; end

  # GET /group_cads/new
  def new
    @group = Group.find(params[:format])

    # Show all group cads at the top
    @group_cads = @group.group_cads
    @group_cads = apply_word_filter(@group_cads, :name, params[:name], group_cads: true) if params[:name].present?

    # Show remaining cads
    @cads = Cad.all - @group_cads.map(&:cad)
    @cads = apply_word_filter(@cads, :name, params[:name]) if params[:name].present?
  end

  # GET /group_cads/1/edit
  def edit; end

  # POST /group_cads
  def create
    @group_cad = GroupCad.new(group_cad_params)
    @group = Group.find(params[:group_cad][:groupId])

    if @group_cad.save
      redirect_to new_group_cad_path(format: @group_cad.groupId), notice: 'CAD was successfully added to Group.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_cads/1
  def update
    if @group_cad.update(group_cad_params)
      redirect_to @group_cad, notice: 'Group cad was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /group_cads/1
  def destroy
    @group_cad.destroy
    redirect_to new_group_cad_path(@group_cad.group), notice: 'CAD was successfully removed from Group.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_cad
    @group_cad = GroupCad.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_cad_params
    params.require(:group_cad).permit(:groupId, :cadId)
  end

  # Filter CADs
  def apply_word_filter(objects, attribute, value, group_cads: false)
    objects.select do |object|
      if group_cads
        object.cad.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end
end
