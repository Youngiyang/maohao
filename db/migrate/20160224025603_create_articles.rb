class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      # 1为正常，2为草稿，3为回收
      t.integer :state, null: false, default: 1
      t.string :content, null: false
      t.integer :order, null: false
      t.string :category, null: false
      t.string :author, null: false
      t.string :excerpt
      t.timestamps null: false
    end
  end
end
