class AddTotalStarAndEvaluationNumberToShops < ActiveRecord::Migration
  def change
    add_column :shops, :total_star, :integer
    add_column :shops, :envaluation_number, :integer
  end
end
