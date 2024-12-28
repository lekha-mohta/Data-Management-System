class CreateCads < ActiveRecord::Migration[7.0]
  def change
    create_table :cads do |t|
      t.string :name
      t.string :type
      t.boolean :archived
      t.binary :file
      t.integer :createdBy
      t.integer :modifiedBy

      t.timestamps
    end
  end
end
