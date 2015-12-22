class AddDiscountAndAlterAttrsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :discount, :float
    change_column :coupons, :cheap, :int, null: true
    change_column :coupons, :min_amount, :int
  end
end
