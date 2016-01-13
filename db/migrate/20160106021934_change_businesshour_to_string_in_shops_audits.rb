class ChangeBusinesshourToStringInShopsAudits < ActiveRecord::Migration
  def change
    change_column :shops_audits, :business_hour_start, :string
    change_column :shops_audits, :business_hour_end, :string
  end
end
