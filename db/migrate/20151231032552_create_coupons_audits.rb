class CreateCouponsAudits < ActiveRecord::Migration
  def change
    create_table :coupons_audits do |t|
      t.integer :state, default: 0 #审核状态 0:待审核, 1:已审核, 2:失效
      t.string :result, default: "" #
      t.integer :coupon_id

      t.string  :name, null:false
      t.text :remark, null: false, default: ''
      t.integer :cc_type, null: false # 1:满减, 2: 折扣
      t.datetime :start_grab_time
      t.datetime :end_grab_time
      t.datetime :start_time
      t.datetime :end_time
      t.integer :period_time
      t.float :cheap, null: false
      t.float :min_amount, null: false, default: 0
      t.integer :total, null: false, default: 0
      t.integer :giveout, null: false, default: 0
      t.integer :used, null: false, default: 0
      t.integer :perlimit, null: false, default: 1
      t.integer :quantity, null: false, default: 1
      # 商家发布优惠劵的状态, 0:失效, 1: 有效, 2: 审核中, 4:审核失败
      # t.integer :state
      # 审核通过时间或者失败时间
      t.datetime :audited_at
      # 审核失败原因
      t.string :audit_reason



      t.timestamps null: false
    end
  end
end
