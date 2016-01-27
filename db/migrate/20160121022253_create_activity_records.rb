class CreateActivityRecords < ActiveRecord::Migration
  def change
    create_table :activity_records do |t|
      t.string :activity_name, null: false
      t.string :mobile, null: false
      t.integer :state, null: false, default: 1
      t.timestamps null: false
    end
  end
end
