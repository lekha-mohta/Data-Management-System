class MachineParamsAddForeignKeys < ActiveRecord::Migration[7.0]
  def change
    rename_column :machine_parameters, :processId, :machineId
    rename_column :build_parameters, :processId, :machineId

    add_foreign_key :machine_parameters, :machines, column: :machineId
    add_foreign_key :machine_parameters, :parameters, column: :parameterId

    add_foreign_key :build_parameters, :machines, column: :machineId
    add_foreign_key :build_parameters, :parameters, column: :parameterId
    add_foreign_key :build_parameters, :builds, column: :buildId
  end
end
