class CreateRecommendedPerfumes < ActiveRecord::Migration[7.1]
  def change
    create_table :recommended_perfumes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.float :score

      t.timestamps
    end

    add_index :recommended_perfumes, [:user_id, :perfume_id], unique: true
  end
end
