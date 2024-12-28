class GroupMachinesController < ApplicationController
  before_action :set_group_machine, only: %i[show edit update destroy]

  authorize_resource

  # GET /group_machines
  def index
    @group_machines = GroupMachine.all
  end

  # GET /group_machines/1
  def show; end

  # GET /group_machines/new
  def new
    @group = Group.find(params[:format])

    # Show all group machines at the top
    @group_machines = @group.group_machines
    if params[:name].present?
      @group_machines = apply_word_filter(@group_machines, :name, params[:name],
                                          group_machines: true)
    end

    # Show remaining machines
    @machines = Machine.all - @group_machines.map(&:machine)
    @machines = apply_word_filter(@machines, :name, params[:name]) if params[:name].present?
  end

  # GET /group_machines/1/edit
  def edit; end

  # POST /group_machines
  def create
    @group_machine = GroupMachine.new(group_machine_params)
    @group = Group.find(params[:group_machine][:groupId])

    if @group_machine.save
      redirect_to new_group_machine_path(format: @group_machine.groupId),
                  notice: 'Machine was successfully added to Group.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_machines/1
  def update
    if @group_machine.update(group_machine_params)
      redirect_to @group_machine, notice: 'Group machine was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /group_machines/1
  def destroy
    @group_machine.destroy
    redirect_to new_group_machine_path(@group_machine.group), notice: 'Machine was successfully removed from Group.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_machine
    @group_machine = GroupMachine.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_machine_params
    params.require(:group_machine).permit(:groupId, :machineId)
  end

  # Filter machines
  def apply_word_filter(objects, attribute, value, group_machines: false)
    objects.select do |object|
      if group_machines
        object.machine.send(attribute).downcase.include?(value.downcase)
      else
        object.send(attribute).downcase.include?(value.downcase)
      end
    end
  end
end
