class RemoveLastGrabColumn < ActiveRecord::Migration
  def change
    remove_column :users, :last_grab_time
  end
end
