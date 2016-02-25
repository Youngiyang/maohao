class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :name, null: false
      t.string :description
      t.integer :count
      t.timestamps null: false
    end
  end
end
