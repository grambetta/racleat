class RenameTypeToDeviceType < ActiveRecord::Migration[6.0]
  def change
    rename_column :devices, :type, :device_type
  end
end
