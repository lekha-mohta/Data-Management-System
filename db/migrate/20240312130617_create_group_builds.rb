class CreateGroupBuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :group_builds do |t|
      t.integer :groupId
      t.integer :buildId

      t.timestamps
    end
  end
end
