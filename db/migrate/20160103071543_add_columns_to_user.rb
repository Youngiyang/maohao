class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :grab_numbers, :integer
    add_column :users, :grab_numbers_limit, :integer
    add_column :users, :last_grab_time, :datetime
  end
end
