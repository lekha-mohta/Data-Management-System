class GroupMaterialsController < ApplicationController
  before_action :set_group_material, only: %i[destroy]

  authorize_resource

  # GET /group_materials/new
  def new
    @group = Group.find(params[:format])

    # Show all group materials at the top
    @group_materials = @group.group_materials
    if params[:name].present?
      @group_materials = apply_word_filter(@group_materials, :name, params[:name],
                                           group_materials: true)
    end

    # Show remaining materials
    @materials = Material.all - @group_materials.map(&:material)
    @materials = apply_word_filter(@materials, :name, params[:name]) if params[:name].present?
  end

  # POST /group_materials
  def create
    @group_material = GroupMaterial.new(group_material_params)
    @group = Group.find(params[:group_material][:groupId])

    if @group_material.save
      redirect_to new_group_material_path(format: @group_material.groupId),
                  notice: 'Group material was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /group_materials/1
  def destroy
    @group_material.destroy
    redirect_to new_group_material_path(@group_material.group), notice: 'Material was successfully removed from group.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_material
    @group_material = GroupMaterial.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_material_params
    params.require(:group_material).permit(:groupId, :materialId)
  end

  # Applies a word filter to a collection of objects based on a specified attribute and value.
  def apply_word_filter(objects, attribute, value, group_materials: false)
    objects.select do |object|
      if group_materials
        object.material.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end

  def apply_sorting
    allowed_sort_columns = %w[name material_type meltingOnset crystallisationOnset created_at
                              updated_at modifiedBy createdBy]
    allowed_order_directions = %w[asc desc]

    if allowed_sort_columns.include?(params[:sort]) && allowed_order_directions.include?(params[:order].downcase)
      @materials = @materials.order("#{params[:sort]} #{params[:order]}")
    end
  end
end
