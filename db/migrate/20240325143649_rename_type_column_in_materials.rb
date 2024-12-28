class RenameTypeColumnInMaterials < ActiveRecord::Migration[7.0]
  def change
    rename_column :materials, :type, :material_type
  end
end
