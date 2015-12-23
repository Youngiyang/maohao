class AddDiscountAndAlterAttrsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :discount, :float # 折扣
    change_column :coupons, :cheap, :int, null: true # 减免
    change_column :coupons, :min_amount, :int
    add_index :coupons, :end_grab_time
  end
end
