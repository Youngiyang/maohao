class AddShopsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shops_count, :integer, :default => 0

    User.pluck(:id).each do |i|
      User.reset_counters(i, :shops) # 全部重算一次
    end

  end
end
