class MaterialFieldsBuildComplete < ActiveRecord::Migration[7.0]
  def change
    add_column :materials, :location, :string
    add_column :builds, :completed, :boolean
  end

  def up
    change_column :materials, :quantity, :string
  end

  def down
    change_column :materials, :quantity, :integer
  end
end
