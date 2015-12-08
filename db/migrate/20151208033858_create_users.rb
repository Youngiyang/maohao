class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick_name
      t.string :avatar
      t.string :email
      t.string :mobile, null: false
      t.string :password_digest, null: false
      t.string :sex
      t.date :birthday
      t.integer :level, null: false, default: 1
      t.boolean :is_seller, null: false, default: false
      t.integer :credit_value
      t.string :real_name
      t.string :identify_sn
      t.datetime :verfied_at
      t.string :auth_token
      # 账号状态, 0:禁用, 1:正常
      t.integer :state, null: false, default: 1
      t.timestamps null: false
    end
    add_index :users, :mobile, unique: true
    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
