class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :grab_numbers_limit
  end
end
