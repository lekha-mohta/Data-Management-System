require 'tempfile'

class CadsController < ApplicationController
  before_action :set_cad, only: %i[show edit update destroy]

  authorize_resource except: :download

  # GET /cads
  def index
    @cads = get_cads

    apply_word_filter(:name, params[:name]) if params[:name].present?
    apply_word_filter(:file_type, params[:file_type]) if params[:file_type].present?

    if params[:createdBy].present?
      @cads = @cads.joins('INNER JOIN users AS created_users ON created_users.id = "cads"."createdBy"')
                   .where('created_users.givenname ILIKE ?', "%#{params[:createdBy]}%")
    end

    if params[:modifiedBy].present?
      @cads = @cads.joins('INNER JOIN users AS modified_users ON modified_users.id = "cads"."modifiedBy"')
                   .where('modified_users.givenname ILIKE ?', "%#{params[:modifiedBy]}%")
    end

    apply_range_filter(:created_at, params[:created_at_min], params[:created_at_max])
    apply_range_filter(:updated_at, params[:updated_at_min], params[:updated_at_max])

    @cads = @cads.where(machine: params[:machineId]) if params[:machineId].present?

    @cads = @cads.where(archived: params[:archived] == 'yes') if params[:archived].present?

    apply_sorting if params[:sort].present? && params[:order].present?
  end

  # GET /cads/1
  def show
    role_number = current_user.get_role_number
    if role_number == 0 and @cad.createdBy != current_user.id and !is_in_my_groups
      redirect_to cads_path, alert: 'You are not authorized to view this CAD.'
    elsif role_number == 1 and @cad.createdBy != current_user.id and !is_in_my_groups
      redirect_to cads_path, alert: 'You are not authorized to view this CAD.'
    elsif role_number == 2 and @cad.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to cads_path, alert: 'You are not authorized to view this CAD.'
    end
  end

  # GET /cads/new
  def new
    @cad = Cad.new
  end

  # GET /cads/1/edit
  def edit
    role_number = current_user.get_role_number

    if role_number == 1 and @cad.createdBy != current_user.id
      redirect_to cads_path, alert: 'You are not authorized to edit this CAD.'
    elsif role_number == 2 and @cad.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to cads_path, alert: 'You are not authorized to view this CAD.'
    end
  end

  # POST /cads
  def create
    @cad = Cad.new(cad_params.except(:file).merge(modifiedBy: current_user.id, createdBy: current_user.id))

    @cad.archived = false

    @cad.file = params[:cad][:file].read if params[:cad][:file].present?

    if @cad.save
      redirect_to @cad, notice: 'Cad was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cads/1
  def update
    @cad.file = params[:cad][:file].read if params[:cad][:file].present?

    if @cad.update(cad_params.except(:file).merge(modifiedBy: current_user.id, updated_at: Time.current))
      redirect_to @cad, notice: 'Cad was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def download
    cad = Cad.find(params[:id])

    # Create a temporary file
    temp_file = Tempfile.new('cad_file')

    # Write the binary data to the file
    temp_file.binmode
    temp_file.write(cad.file)
    temp_file.rewind

    # Send the file
    send_file temp_file.path, filename: cad.name, type: 'application/octet-stream'

    # Close and delete the temporary file
    temp_file.close
  end

  private

  def set_cad
    @cad = Cad.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cad_params
    params.require(:cad).permit(:name, :file_type, :archived, :file, :createdBy, :modifiedBy, :machineId)
  end

  def is_commercial
    @cad.groups.exists?(name: 'Commercially Available')
  end

  def is_in_my_groups
    # check if current material is in the data returned by my_group_data
    my_group_data.include?(@cad)
  end

  def my_group_data
    Cad.joins(:group_cads).where(group_cads: { groupId: current_user.groups.pluck(:id) })
  end

  def my_data
    Cad.where(created_by: current_user.id)
  end

  def commercial_data
    Cad.joins(:group_cads).where(group_cads: { groupId: Group.where(name: 'Commercially Available').first.id })
  end

  def get_cads
    cads = []
    # User can only access data that they have been assigned to.
    cads += my_group_data if current_user.get_role_number >= 0
    # Students can also see data created by them.
    cads += my_data if current_user.get_role_number >= 1
    # Staff gets all commercially available data
    cads += commercial_data if current_user.get_role_number >= 2
    # Admins get all data
    cads = Cad.all if current_user.get_role_number == 3

    Cad.where(id: cads.map(&:id))
  end

  def apply_word_filter(attribute, value)
    @cads = @cads.where("\"cads\".\"#{attribute}\" ILIKE ?", "%#{value}%")
  end

  def apply_range_filter(attribute, min, max)
    @cads = @cads.where("\"cads\".\"#{attribute}\" >= ?", min) if min.present?
    @cads = @cads.where("\"cads\".\"#{attribute}\" <= ?", max) if max.present?
  end

  def apply_sorting
    allowed_sort_columns = %w[name file_type created_at updated_at modifiedBy createdBy machineId]
    allowed_order_directions = %w[asc desc]

    unless allowed_sort_columns.include?(params[:sort]) && allowed_order_directions.include?(params[:order].downcase)
      return
    end

    @cads = if params[:sort] == 'createdBy'
              @cads.joins(:created_by).order("users.givenname #{params[:order]}")
            elsif params[:sort] == 'modifiedBy'
              @cads.joins(:modified_by).order("users.givenname #{params[:order]}")
            elsif params[:sort] == 'machineId'
              @cads.joins(:machine).order("machine.name #{params[:order]}")
            else
              @cads.order("#{params[:sort]} #{params[:order]}")
            end
  end
end
