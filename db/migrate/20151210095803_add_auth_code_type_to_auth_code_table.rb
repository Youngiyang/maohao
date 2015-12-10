class AddAuthCodeTypeToAuthCodeTable < ActiveRecord::Migration
  def change
    add_column :auth_codes, :auth_code_type, :string
  end
end
