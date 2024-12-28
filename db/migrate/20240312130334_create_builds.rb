class CreateBuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :builds do |t|
      t.integer :materialId
      t.integer :processId
      t.integer :projectId
      t.string :name
      t.string :comments
      t.boolean :archived
      t.float :avgUTS
      t.float :avgModules
      t.float :avgEaB
      t.integer :createdBy
      t.integer :modifiedBy

      t.timestamps
    end
  end
end
