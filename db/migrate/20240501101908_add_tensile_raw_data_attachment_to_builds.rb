class AddTensileRawDataAttachmentToBuilds < ActiveRecord::Migration[7.0]
  def change
    add_column :builds, :tensile_raw_data, :binary
  end
end
