require 'tempfile'

class MaterialsController < ApplicationController
  before_action :set_material, only: %i[show edit update destroy]

  authorize_resource except: :download

  # GET /materials
  def index
    @materials = get_materials

    apply_word_filter(:name, params[:name]) if params[:name].present?
    apply_word_filter(:material_type, params[:material_type]) if params[:material_type].present?

    if params[:createdBy].present?
      @materials = @materials.joins('INNER JOIN users AS created_users ON created_users.id = "materials"."createdBy"')
                             .where('created_users.givenname ILIKE ?', "%#{params[:createdBy]}%")
    end

    if params[:modifiedBy].present?
      @materials = @materials.joins('INNER JOIN users AS modified_users ON modified_users.id = "materials"."modifiedBy"')
                             .where('modified_users.givenname ILIKE ?', "%#{params[:modifiedBy]}%")
    end

    apply_range_filter(:created_at, params[:created_at_min], params[:created_at_max])
    apply_range_filter(:updated_at, params[:updated_at_min], params[:updated_at_max])

    apply_range_filter(:meltingOnset, params[:meltingOnset_min], params[:meltingOnset_max])
    apply_range_filter(:crystallisationOnset, params[:crystallisationOnset_min], params[:crystallisationOnset_max])

    if params[:archived].present?
      @materials = if params[:archived] == 'yes'
                     @materials.where(archived: true)
                   else
                     @materials.where(archived: false)
                   end
    end

    apply_sorting if params[:sort].present? && params[:order].present?
  end

  # GET /materials/1
  def show
    role_number = current_user.get_role_number
    if role_number == 0 and @material.createdBy != current_user.id and !is_in_my_groups
      redirect_to materials_path, alert: 'You are not authorized to view this material.'
    elsif role_number == 1 and @material.createdBy != current_user.id and !is_in_my_groups
      redirect_to materials_path, alert: 'You are not authorized to view this material.'
    elsif role_number == 2 and @material.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to materials_path, alert: 'You are not authorized to view this material.'
    end
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
    role_number = current_user.get_role_number

    if role_number == 1 and @material.createdBy != current_user.id
      redirect_to materials_path, alert: 'You are not authorized to edit this material.'
    elsif role_number == 2 and @material.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to materials_path, alert: 'You are not authorized to view this material.'
    end
  end

  # POST /materials
  def create
    @material = Material.new(material_params.except(:MSDS, :CoSHH, :DSC, :FT4).merge(modifiedBy: current_user.id,
                                                                                     createdBy: current_user.id))

    @material.archived = false

    @material.MSDS = params[:material][:MSDS].read if params[:material][:MSDS].present?
    @material.CoSHH = params[:material][:CoSHH].read if params[:material][:CoSHH].present?
    @material.DSC = params[:material][:DSC].read if params[:material][:DSC].present?
    @material.FT4 = params[:material][:FT4].read if params[:material][:FT4].present?

    if @material.save
      redirect_to @material, notice: 'Material was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /materials/1
  def update
    # Checking if a material is referenced by its material_id
    if Build.where(materialId: @material.id).exists?
      redirect_to @material, alert: 'Material cannot be updated since it is referenced.'
    else
      @material.MSDS = params[:material][:MSDS].read if params[:material][:MSDS].present?
      @material.CoSHH = params[:material][:CoSHH].read if params[:material][:CoSHH].present?
      @material.DSC = params[:material][:DSC].read if params[:material][:DSC].present?
      @material.FT4 = params[:material][:FT4].read if params[:material][:FT4].present?

      if @material.update(material_params.except(:MSDS, :CoSHH, :DSC, :FT4).merge(modifiedBy: current_user.id,
                                                                                  updated_at: Time.current))
        redirect_to @material, notice: 'Material was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /materials/1
  def destroy
    if @build.material.name == @material.name || @machine.material.name == @material.name || @cad.material.name == @cad.name
      redirect_to @material, alert: 'Material cannot be deleted since it is referenced.'
    else
      @material.destroy
      redirect_to materials_url, notice: 'Material was successfully destroyed.', status: :see_other
    end
  end

  def download
    @material = Material.find(params[:id])

    # Get the attribute name and file data
    attribute = params[:attribute].to_sym
    file_data = @material.send(attribute)

    # Create a temporary file
    temp_file = Tempfile.new('material_attribute_file')

    # Write the binary data to the file
    temp_file.binmode
    temp_file.write(file_data)
    temp_file.rewind

    # Send the file
    send_file temp_file.path, filename: "#{@material.name}_#{attribute}", type: 'application/octet-stream'

    # Close and delete the temporary file
    temp_file.close
  end

  def download
    @material = Material.find(params[:id])

    # Get the attribute name and file data
    attribute = params[:attribute].to_sym
    file_data = @material.send(attribute)

    # Create a temporary file
    temp_file = Tempfile.new('material_attribute_file')

    # Write the binary data to the file
    temp_file.binmode
    temp_file.write(file_data)
    temp_file.rewind

    # Send the file
    send_file temp_file.path, filename: "#{@material.name}_#{attribute}", type: 'application/octet-stream'

    # Close and delete the temporary file
    temp_file.close
  end

  private

  # Your private methods here

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material = Material.find(params[:id])
  end

  def is_commercial
    @material.groups.exists?(name: 'Commercially Available')
  end

  def is_in_my_groups
    # check if current material is in the data returned by my_group_data
    my_group_data.include?(@material)
  end

  def my_group_data
    Material.joins(:group_materials).where(group_materials: { groupId: current_user.groups.pluck(:id) })
  end

  def my_data
    Material.where(created_by: current_user.id)
  end

  def commercial_data
    Material.joins(:group_materials).where(group_materials: { groupId: Group.where(name: 'Commercially Available').first.id })
  end

  def get_materials
    material = []
    # User can only access data that they have been assigned to.
    material += my_group_data if current_user.get_role_number >= 0
    # Students can also see data created by them.
    material += my_data if current_user.get_role_number >= 1
    # Staff gets all commercially available data
    material += commercial_data if current_user.get_role_number >= 2
    # Admins get all data
    material = Material.all if current_user.get_role_number == 3

    Material.where(id: material.map(&:id))
  end

  # Only allow a list of trusted parameters through.
  def material_params
    params.require(:material).permit(:name, :description, :quantity, :material_type, :archived,
                                     :meltingOnset, :location, :crystallisationOnset, :MSDS, :CoSHH, :DSC, :FT4, :createdBy, :modifiedBy)
  end

  def apply_word_filter(attribute, value)
    @materials = @materials.where("\"materials\".\"#{attribute}\" ILIKE ?", "%#{value}%")
  end

  def apply_range_filter(attribute, min, max)
    @materials = @materials.where("\"materials\".\"#{attribute}\" >= ?", min) if min.present?
    @materials = @materials.where("\"materials\".\"#{attribute}\" <= ?", max) if max.present?
  end

  def apply_sorting
    allowed_sort_columns = %w[name material_type meltingOnset crystallisationOnset created_at
                              updated_at modifiedBy createdBy location]
    allowed_order_directions = %w[asc desc]

    unless allowed_sort_columns.include?(params[:sort]) && allowed_order_directions.include?(params[:order].downcase)
      return
    end

    @materials = if params[:sort] == 'createdBy'
                   @materials.joins(:created_by).order("users.givenname #{params[:order]}")
                 elsif params[:sort] == 'modifiedBy'
                   @materials.joins(:modified_by).order("users.givenname #{params[:order]}")
                 else
                   @materials.order(Arel.sql("\"#{params[:sort]}\" #{params[:order]}"))
                 end
  end
end
