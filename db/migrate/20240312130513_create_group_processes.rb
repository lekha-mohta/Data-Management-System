class CreateGroupProcesses < ActiveRecord::Migration[7.0]
  def change
    create_table :group_machines do |t|
      t.integer :groupId
      t.integer :processId

      t.timestamps
    end
  end
end
