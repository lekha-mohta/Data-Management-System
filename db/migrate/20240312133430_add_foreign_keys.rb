class AddForeignKeys < ActiveRecord::Migration[7.0]
  def change
    rename_table :attachment_processes, :attachment_machines

    rename_column :group_machines, :processId, :machineId
    rename_column :builds, :processId, :machineId
    rename_column :attachment_machines, :processId, :machineId

    add_foreign_key :attachment_builds, :attachments, column: :attachmentId
    add_foreign_key :attachment_builds, :builds, column: :buildId

    add_foreign_key :group_builds, :groups, column: :groupId
    add_foreign_key :group_builds, :builds, column: :buildId

    add_foreign_key :group_users, :groups, column: :groupId
    add_foreign_key :group_users, :users, column: :userId

    add_foreign_key :group_cads, :groups, column: :groupId
    add_foreign_key :group_cads, :cads, column: :cadId

    add_foreign_key :group_materials, :groups, column: :groupId
    add_foreign_key :group_materials, :materials, column: :materialId

    add_foreign_key :group_machines, :groups, column: :groupId
    add_foreign_key :group_machines, :machines, column: :machineId

    add_foreign_key :builds, :materials, column: :materialId
    add_foreign_key :builds, :machines, column: :machineId
    add_foreign_key :builds, :build_projects, column: :projectId

    add_foreign_key :attachment_machines, :attachments, column: :attachmentId
    add_foreign_key :attachment_machines, :machines, column: :machineId
  end
end
