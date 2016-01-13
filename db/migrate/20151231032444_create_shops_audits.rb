class CreateShopsAudits < ActiveRecord::Migration
  def change
    create_table :shops_audits do |t|
      t.integer :state, default: 0 #审核状态 0:待审核, 1:已审核, 2:失效
      t.string :result, default: "" #
      t.integer :shop_id

      t.integer :first_class_id, null: false
      t.integer :second_class_id, null: false, default: 0
      t.string :name, null: false
      t.string :logo
      t.json :images
      t.integer :region_id, null: false
      t.string  :address, null: false
      t.st_point :location, null: false, geographic: true
      t.string  :telephone, null: false
      t.time  :business_hour_start, null: false
      t.time  :business_hour_end, null: false
      t.boolean :business_on_holiday, null: false, default: true
      t.float :star_grade, null: false, default: 5
      t.integer :user_id, null: false
      t.boolean :is_recommand, null: false, default: false
      t.text :description, null: false, default: ''
      t.boolean :is_own, null: false, default: false
      t.text :notice, null: false, default: ''
      # 店铺状态, 0:关闭, 1:开启, 2:审核中, 4:审核失败
      # t.integer :state, null: false
      # 审核通过时间或者失败时间
      # 审核失败原因
      t.string :audit_reason
      t.timestamps null: false
    end
  end
end
