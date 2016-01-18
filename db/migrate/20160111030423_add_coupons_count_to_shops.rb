class AddCouponsCountToShops < ActiveRecord::Migration
  def change
    add_column :shops, :coupons_count, :integer, :default => 0

    Shop.pluck(:id).each do |i|
      Shop.reset_counters(i, :coupons) # 全部重算一次
    end
  end
end
