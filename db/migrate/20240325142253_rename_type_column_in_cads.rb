class RenameTypeColumnInCads < ActiveRecord::Migration[7.0]
  def change
    rename_column :cads, :type, :file_type
  end
end
