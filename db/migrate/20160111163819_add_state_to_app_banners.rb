class AddStateToAppBanners < ActiveRecord::Migration
  def change
    add_column :app_banners, :state, :integer, null: false, default: 1 # 1 有效, 2 失效
  end
end
