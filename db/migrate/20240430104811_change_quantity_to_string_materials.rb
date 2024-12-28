class ChangeQuantityToStringMaterials < ActiveRecord::Migration[7.0]
  def up
    change_column :materials, :quantity, :string
  end

  def down
    change_column :materials, :quantity, :integer
  end
end
