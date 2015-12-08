class CreateCouponItems < ActiveRecord::Migration
  def change
    create_table :coupon_items do |t|
      t.integer :user_id, null: false
      t.integer :coupon_id, null: false
      t.string  :coupon_sn, null: false
      # 用户优惠劵状态, 0:未使用, 1:已使用, 2:过期, 3:回收
      t.integer :state, null: false, default: 0
      # 优惠劵使用时间
      t.datetime :used_at
      # 优惠劵过期时间
      t.datetime :expired_at, null: false
      t.timestamps null: false
    end
    add_index :coupon_items, :user_id
    add_index :coupon_items, :coupon_id
    add_index :coupon_items, :coupon_sn, unique: true
  end
end
