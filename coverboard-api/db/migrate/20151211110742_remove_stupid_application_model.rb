class RemoveStupidApplicationModel < ActiveRecord::Migration
  def change
    remove_column :metrics, :application_id
    drop_table :applications
  end
end
