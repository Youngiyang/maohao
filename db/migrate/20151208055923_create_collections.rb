class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id, null: false
      t.string  :object_type, null: false
      t.integer :object_id, null: false
      t.timestamps null: false
    end
  end
end
