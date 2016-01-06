class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :grab_numbers, :integer, default: 3
    add_column :users, :grab_numbers_limit, :integer, default: 3
    add_column :users, :last_grab_time, :datetime
  end
end
