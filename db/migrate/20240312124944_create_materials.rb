class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.string :type
      t.boolean :archived
      t.float :meltingOnset
      t.float :crystallisationOnset
      t.binary :MSDS
      t.binary :CoSHH
      t.binary :DSC
      t.binary :FT4
      t.string :createdBy
      t.string :modifiedBy

      t.timestamps
    end
  end
end
