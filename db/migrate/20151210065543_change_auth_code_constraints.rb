class ChangeAuthCodeConstraints < ActiveRecord::Migration
  def self.up
    remove_index :auth_codes, :mobile
    add_index :auth_codes, :mobile
    change_column :auth_codes, :sent_at, :datetime, null: true
  end

  def self.down
  end
end
