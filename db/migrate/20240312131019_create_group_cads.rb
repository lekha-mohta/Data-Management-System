class CreateGroupCads < ActiveRecord::Migration[7.0]
  def change
    create_table :group_cads do |t|
      t.integer :groupId
      t.integer :cadId

      t.timestamps
    end
  end
end
