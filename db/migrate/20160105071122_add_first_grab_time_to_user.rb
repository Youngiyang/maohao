class AddFirstGrabTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_grab_time, :datetime
  end
end
