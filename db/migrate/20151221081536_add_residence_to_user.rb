class AddResidenceToUser < ActiveRecord::Migration
  def change
    add_column :users, :residence, :string
  end
end
