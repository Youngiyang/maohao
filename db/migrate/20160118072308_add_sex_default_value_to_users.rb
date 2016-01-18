class AddSexDefaultValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :sex, :string, null: false, default: 'secret'
  end
end
