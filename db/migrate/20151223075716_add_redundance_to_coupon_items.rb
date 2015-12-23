class AddRedundanceToCouponItems < ActiveRecord::Migration
  def change
    add_column :coupon_items, :shop_id, :string, null: false
    add_column :coupon_items, :shop_name, :string, null: false
    add_column :coupon_items, :coupon_name, :string, null: false
    add_column :coupon_items, :coupon_type, :integer, null: false
    add_column :coupon_items, :coupon_cheap, :integer
    add_column :coupon_items, :coupon_discount, :float
    add_column :coupon_items, :coupon_start_time, :datetime
    add_column :coupon_items, :coupon_end_time, :datetime
    add_column :coupon_items, :coupon_min_amount, :integer
  end
end
