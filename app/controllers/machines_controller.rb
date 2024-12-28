class MachinesController < ApplicationController
  before_action :set_machine, only: %i[show edit update destroy]

  authorize_resource

  # GET /machines
  def index
    @machines = get_machines
    @machines = @machines.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%") if params[:name].present?
  end

  # GET /machines/1
  def show; end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
    @machine = Machine.find(params[:id])
    @set_params = params[:set_params] if params[:set_params].present?
    @machine_parameters = @machine.machine_parameters
    if params[:name].present?
      @machine_parameters = apply_word_filter(@machine_parameters, :name, params[:name],
                                              machine_parameters: true)
    end

    @parameters = Parameter.all - @machine_parameters.map(&:parameter)
    if params[:name].present?
      @parameters = apply_word_filter(@parameters, :name, params[:name],
                                      machine_parameters: false)
    end
    return unless params[:set_params] == 'true'

    render 'set_parameters'
  end

  # POST /machines
  def create
    @machine = Machine.new(machine_params.merge(created_by: current_user, modified_by: current_user))

    if @machine.save
      redirect_to @machine, notice: 'Machine was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /machines/1
  def update
    if Build.where(machineId: @machine.id).exists? || Cad.where(machineId: @machine.id).exists?
      redirect_to @machine, alert: 'Machine cannot be edited as it is referenced by a build or cad.'
    elsif @machine.update(machine_params.merge(modified_by: current_user))
      redirect_to @machine, notice: 'Machine was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /machines/1
  def destroy
    @machine.destroy
    redirect_to machines_url, notice: 'Machine was successfully destroyed.', status: :see_other
  end

  def parameters
    @machine = Machine.find(params[:id])
    respond_to do |format|
      format.js { render partial: 'parameters', locals: { machine: @machine } }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_machine
    @machine = Machine.find(params[:id])
  end

  def my_group_data
    Machine.joins(:group_machines).where(group_machines: { groupId: current_user.groups.pluck(:id) })
  end

  def my_data
    Machine.where(created_by: current_user.id)
  end

  def commercial_data
    Machine.joins(:group_machines).where(group_machines: { groupId: Group.where(name: 'Commercially Available').first.id })
  end

  def get_machines
    machines = []
    # User can only access data that they have been assigned to.
    machines += my_group_data if current_user.get_role_number >= 0
    # Students can also see data created by them.
    machines += my_data if current_user.get_role_number >= 1
    # Staff gets all commercially available data
    machines += commercial_data if current_user.get_role_number >= 2
    # Admins get all data
    machines = Machine.all if current_user.get_role_number == 3

    Machine.where(id: machines.map(&:id))
  end

  # Only allow a list of trusted parameters through.
  def machine_params
    params.require(:machine).permit(:name, :description, :archived)
  end

  # Applies a word filter to a collection of objects based on a specified attribute and value.
  def apply_word_filter(objects, attribute, value, machine_parameters: false)
    objects.select do |object|
      if machine_parameters
        object.parameter.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end
end
