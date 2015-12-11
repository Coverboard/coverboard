class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :uid

      t.timestamps null: false
    end

    add_column :metrics, :project_id, :integer
  end
end
