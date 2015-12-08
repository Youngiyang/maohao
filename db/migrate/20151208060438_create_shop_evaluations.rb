class CreateShopEvaluations < ActiveRecord::Migration
  def change
    create_table :shop_evaluations do |t|
      t.integer :user_id, null: false
      t.string  :user_nick_name, null: false
      t.integer :shop_id, null: false
      t.integer :star_grade, null: false, default: 1
      t.string :content, null: false
      t.timestamps null: false
    end
  end
end
