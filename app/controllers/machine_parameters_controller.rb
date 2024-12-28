# This is the MachineParametersController responsible for handling HTTP requests related to MachineParameter objects.
# This includes actions to create, read, update, and delete (CRUD) MachineParameter objects.

class MachineParametersController < ApplicationController
  before_action :set_machine_parameter, only: %i[show edit update destroy]

  # GET /machine_parameters
  def index
    @machine_parameters = MachineParameter.all
  end

  # GET /machine_parameters/1
  def show; end

  # GET /machine_parameters/new
  def new
    @machine_parameter = MachineParameter.new
  end

  # GET /machine_parameters/1/edit
  def edit; end

  # POST /machine_parameters
  def create
    @machine_parameter = MachineParameter.new(machine_parameter_params)

    if @machine_parameter.save
      redirect_to edit_machine_path(@machine_parameter.machine, set_params: true),
                  notice: 'Parameter was successfully added to machine.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /machine_parameters/1
  def update
    if @machine_parameter.update(machine_parameter_params)
      redirect_to @machine_parameter, notice: 'Machine parameter was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /machine_parameters/1
  def destroy
    @machine_parameter.destroy
    redirect_to machine_parameters_url, notice: 'Machine parameter was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_machine_parameter
    @machine_parameter = MachineParameter.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def machine_parameter_params
    params.require(:machine_parameter).permit(:machineId, :parameterId)
  end
end
