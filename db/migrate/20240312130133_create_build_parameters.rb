class CreateBuildParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :build_parameters do |t|
      t.integer :buildId
      t.integer :processId
      t.integer :parameterId
      t.string :value

      t.timestamps
    end
  end
end
