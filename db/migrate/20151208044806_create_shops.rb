class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
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
      t.boolean :is_recommand, null: false, default: true
      t.text :description, null: false, default: ''
      t.boolean :is_own, null: false, default: false
      t.text :notice, null: false, default: ''
      # 店铺状态, 0:关闭, 1:开启, 2:审核中, 4:审核失败
      t.integer :state, null: false
      # 审核通过时间或者失败时间
      t.datetime :audited_at
      # 审核失败原因
      t.string :audit_reason
      t.timestamps null: false
    end
    add_index :shops, :name
    add_index :shops, :first_class_id
    add_index :shops, :second_class_id
    add_index :shops, :location, using: :gist
  end
end
