class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :name
      t.binary :file

      t.timestamps
    end
  end
end
