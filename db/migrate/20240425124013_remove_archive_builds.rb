class RemoveArchiveBuilds < ActiveRecord::Migration[7.0]
  def change
    remove_column :builds, :archived
  end
end
