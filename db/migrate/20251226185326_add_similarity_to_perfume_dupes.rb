class AddSimilarityToPerfumeDupes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfume_dupes, :similarity, :integer
  end
end
