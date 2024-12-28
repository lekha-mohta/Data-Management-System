class CreateAttachmentProcesses < ActiveRecord::Migration[7.0]
  def change
    create_table :attachment_processes do |t|
      t.integer :attachmentId
      t.integer :processId

      t.timestamps
    end
  end
end
