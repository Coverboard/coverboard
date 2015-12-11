class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :uid
    end
  end
end
