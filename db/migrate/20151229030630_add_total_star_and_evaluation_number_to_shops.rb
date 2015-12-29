class AddTotalStarAndEvaluationNumberToShops < ActiveRecord::Migration
  def change
    add_column :shops, :total_star, :integer, null: false, default: 0
    add_column :shops, :envaluation_number, :integer, null: false, default: 0
  end
end
