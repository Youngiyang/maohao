class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks do |t|
      t.integer :user_id, null: false
      t.string :content, null: false
      t.timestamps null: false
    end
  end
end
