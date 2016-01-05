class AddCityIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :city_id, :integer, null: false, default: 0
  end
end
