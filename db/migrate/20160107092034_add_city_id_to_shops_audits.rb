class AddCityIdToShopsAudits < ActiveRecord::Migration
  def change
    add_column :shops_audits, :city_id, :integer
  end
end
