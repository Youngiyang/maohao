class CreateAuthCodes < ActiveRecord::Migration
  def change
    create_table :auth_codes do |t|
      t.string :mobile, null: false
      t.string :code, null: false
      t.boolean :auth_state, null: false, defualt: false
      t.integer :validated_time, null: false, default: 0
      t.datetime :sent_at, null: false
      t.datetime :expire_at, null: false
    end
    add_index :auth_codes, :mobile, unique: true
  end
end
