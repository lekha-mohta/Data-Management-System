class CreateMachineParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :machine_parameters do |t|
      t.integer :processId
      t.integer :parameterId

      t.timestamps
    end
  end
end
