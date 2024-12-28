class BuildsController < ApplicationController
  before_action :set_build, only: %i[show edit update destroy]

  authorize_resource except: :download

  # GET /builds
  def index
    @build = get_builds

    apply_word_filter(:name, params[:name]) if params[:name].present?
    apply_dropdown_filter(:projectId, params[:projectId]) if params[:projectId].present?
    apply_dropdown_filter(:machineId, params[:machineId]) if params[:machineId].present?
    apply_dropdown_filter(:materialId, params[:materialId]) if params[:materialId].present?

    if params[:createdBy].present?
      @build = @build.joins('INNER JOIN users AS created_users ON created_users.id = "builds"."createdBy"')
                     .where('created_users.givenname ILIKE ?', "%#{params[:createdBy]}%")
    end

    if params[:modifiedBy].present?
      @build = @build.joins('INNER JOIN users AS modified_users ON modified_users.id = "builds"."modifiedBy"')
                     .where('modified_users.givenname ILIKE ?', "%#{params[:modifiedBy]}%")
    end

    apply_range_filter(:created_at, params[:created_at_min], params[:created_at_max])
    apply_range_filter(:updated_at, params[:updated_at_min], params[:updated_at_max])

    apply_range_filter(:avgUTS, params[:avgUTS_min], params[:avgUTS_max])
    apply_range_filter(:avgModules, params[:avgModules_min], params[:avgModules_max])
    apply_range_filter(:avgEaB, params[:avgEaB_min], params[:avgEaB_max])

    apply_sorting if params[:sort].present? && params[:order].present?
  end

  # GET /build/1
  def show
    role_number = current_user.get_role_number
    if role_number == 0 and @build.createdBy != current_user.id and !is_in_my_groups
      redirect_to builds_path, alert: 'You are not authorized to view this build.'
    elsif role_number == 1 and @build.createdBy != current_user.id and !is_in_my_groups
      redirect_to builds_path, alert: 'You are not authorized to view this build.'
    elsif role_number == 2 and @build.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to builds_path, alert: 'You are not authorized to view this build.'
    end

    @build = Build.find(params[:id])
    @build_parameters = @build.build_parameters
  end

  # GET /build/new
  def new
    @build = Build.new
    @machine = Machine.find(params[:machineId]) if params[:machineId] && Machine.exists?(params[:machineId])
    @parameters = @machine.parameters if @machine
  end

  # GET /build/1/edit
  def edit
    role_number = current_user.get_role_number

    if role_number == 1 and @build.createdBy != current_user.id
      redirect_to builds_path, alert: 'You are not authorized to edit this build.'
    elsif role_number == 2 and @build.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to builds_path, alert: 'You are not authorized to view this build.'
    end

    @build = Build.find(params[:id])
    @machine = @build.machine
    @build_parameters = @build.build_parameters if @machine
  end

  # POST /build
  def create
    @build = Build.new(build_params.except(:tensile_raw_data))
    @build.createdBy = current_user.id
    @build.modifiedBy = current_user.id

    @build.tensile_raw_data = params[:build][:tensile_raw_data].read if params[:build][:tensile_raw_data].present?

    param_ids = params[:paramIds].values.map { |value| value.gsub('value ', '').to_i } if params[:paramIds]
    param_values = params[:paramValues].values if params[:paramValues]

    if @build.save
      # Create build parameters
      if param_ids && param_values
        param_ids.each_with_index do |param_id, index|
          build_parameter = BuildParameter.new(buildId: @build.id, parameterId: param_id, value: param_values[index])
          if build_parameter.save
            Rails.logger.info "PARAMS: #{build_parameter.buildId} #{build_parameter.parameterId} #{build_parameter.value}"
          end
        end
      end
      redirect_to @build, notice: 'Build was successfully created.'
    else
      @machine = Machine.find(@build.machineId) if @build.machineId && Machine.exists?(@build.machineId)
      @parameters = @machine.parameters if @machine
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /build/1
  def update
    role_number = current_user.get_role_number
    if role_number == 1 and @build.createdBy != current_user.id
      redirect_to builds_path, alert: 'You are not authorized to edit this build.' and return
    elsif role_number == 2 and @build.createdBy != current_user.id and (!is_commercial or !is_in_my_groups)
      redirect_to builds_path, alert: 'You are not authorized to edit this build.' and return
    end

    @build = Build.find(params[:id])
    @build.modifiedBy = current_user.id

    @build.tensile_raw_data = params[:build][:tensile_raw_data].read if params[:build][:tensile_raw_data].present?

    param_ids = params[:paramIds].values.map { |value| value.gsub('value ', '').to_i } if params[:paramIds]
    param_values = params[:paramValues].values if params[:paramValues]

    if @build.update(build_params.except(:tensile_raw_data).merge(modifiedBy: current_user.id,
                                                                  updated_at: Time.current))
      # Update build parameters
      if param_ids && param_values
        param_ids.each_with_index do |param_id, index|
          build_parameter = @build.build_parameters.find_by(parameterId: param_id)
          next unless build_parameter

          build_parameter.update(value: param_values[index])
        end
      end
      redirect_to @build, notice: 'Build was successfully updated.', status: :see_other
    else
      @build.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def download
    build = Build.find(params[:id])

    # Create a temporary file
    temp_file = Tempfile.new('build_file')

    # Write the binary data to the file
    temp_file.binmode
    temp_file.write(build.tensile_raw_data)
    temp_file.rewind

    # Send the file
    send_file temp_file.path, filename: "#{build.name}_tensile_raw_data", type: 'application/octet-stream'

    # Close and delete the temporary file
    temp_file.close
  end

  private

  def set_build
    @build = Build.find(params[:id])
  end

  def is_commercial
    @build.groups.exists?(name: 'Commercially Available')
  end

  def is_in_my_groups
    # check if the current build is in the data returned by my_group_data
    my_group_data.include?(@build)
  end

  def machine_parameters
    machine_parameters = Machine.find(params[:machineId]).machine_parameters
    @parameters = machine_parameters.map { |parameter| parameter.parameter }
  end

  def is_commercial
    @build.groups.exists?(name: 'Commercially Available')
  end

  def is_in_my_groups
    # check if current build is in the data returned by my_group_data
    my_group_data.include?(@build)
  end

  def my_group_data
    Build.joins(:group_builds).where(group_builds: { groupId: current_user.groups.pluck(:id) })
  end

  def my_data
    Build.where(created_by: current_user.id)
  end

  def commercial_data
    Build.joins(:group_builds).where(group_builds: { groupId: Group.where(name: 'Commercially Available').first.id })
  end

  def get_builds
    build = []
    # User can only access data that they have been assigned to.
    build += my_group_data if current_user.get_role_number >= 0
    # Students can also see data created by them.
    build += my_data if current_user.get_role_number >= 1
    # Staff gets all commercially available data
    build += commercial_data if current_user.get_role_number >= 2
    # Admins get all data
    build = Build.all if current_user.get_role_number == 3

    Build.where(id: build.map(&:id))
  end

  def apply_dropdown_filter(attribute, value)
    @build = @build.where(attribute => value)
  end

  # Only allow a list of trusted parameters through.
  def build_params
    params.require(:build).permit(:name, :comments, :projectId, :materialId, :machineId, :avgUTS, :avgModules, :avgEaB,
                                  :completed, :tensile_raw_data)
  end

  def apply_word_filter(attribute, value)
    @build = @build.where("\"builds\".\"#{attribute}\" ILIKE ?", "%#{value}%")
  end

  def apply_range_filter(attribute, min, max)
    @build = @build.where("\"builds\".\"#{attribute}\" >= ?", min) if min.present?
    @build = @build.where("\"builds\".\"#{attribute}\" <= ?", max) if max.present?
  end

  def apply_sorting
    allowed_sort_columns = %w[name created_at updated_at modifiedBy createdBy avgUTS avgModules
                              avgEaB]
    allowed_order_directions = %w[asc desc]

    if allowed_sort_columns.include?(params[:sort]) && allowed_order_directions.include?(params[:order].downcase)
      @build = @build.order("\"#{params[:sort]}\" #{params[:order]}")
    end
  end
end
