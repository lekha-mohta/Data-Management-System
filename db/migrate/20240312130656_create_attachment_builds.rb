class CreateAttachmentBuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :attachment_builds do |t|
      t.integer :attachmentId
      t.integer :buildId

      t.timestamps
    end
  end
end
