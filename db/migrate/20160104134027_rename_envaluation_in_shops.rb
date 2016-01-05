class RenameEnvaluationInShops < ActiveRecord::Migration
  def change
    rename_column :shops, :envaluation_number, :evaluation_number
  end
end
