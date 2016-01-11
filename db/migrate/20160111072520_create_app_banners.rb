class CreateAppBanners < ActiveRecord::Migration
  def change
    create_table :app_banners do |t|
      t.string :title, null: false
      t.string :image, null: false
      t.string :url, null: false
      t.string :jump_type, null: false
      t.timestamps null: false
    end
  end
end
