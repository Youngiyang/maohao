class AddImageToCouponsAudits < ActiveRecord::Migration
  def change
  	add_column :coupons_audits, :image, :string, null: false, default: ''
  end
end
