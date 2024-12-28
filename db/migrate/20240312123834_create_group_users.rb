class CreateGroupUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :group_users do |t|
      t.integer :groupId
      t.integer :userId

      t.timestamps
    end
  end
end
