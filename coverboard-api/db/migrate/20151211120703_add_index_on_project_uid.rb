class AddIndexOnProjectUid < ActiveRecord::Migration
  def change
    add_index :projects, :uid
  end
end
