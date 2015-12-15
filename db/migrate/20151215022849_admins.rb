class Admins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.integer :group_id, null: false, default: 1
      t.string :password_digest, null: false
      t.boolean :is_super, null: false, default: false
      t.timestamps null: false
    end
  end
end
