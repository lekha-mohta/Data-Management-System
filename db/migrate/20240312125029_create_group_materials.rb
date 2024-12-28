class CreateGroupMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :group_materials do |t|
      t.integer :groupId
      t.integer :materialId

      t.timestamps
    end
  end
end
