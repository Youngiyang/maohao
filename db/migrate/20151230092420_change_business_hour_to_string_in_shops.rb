class ChangeBusinessHourToStringInShops < ActiveRecord::Migration
  def change
    change_column :shops, :business_hour_start, :string
    change_column :shops, :business_hour_end, :string
  end
end
