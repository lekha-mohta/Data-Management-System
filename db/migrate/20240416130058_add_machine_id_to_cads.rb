class AddMachineIdToCads < ActiveRecord::Migration[7.0]
  def change
    add_column :cads, :machineId, :integer
    add_foreign_key :cads, :machines, column: :machineId
  end
end
