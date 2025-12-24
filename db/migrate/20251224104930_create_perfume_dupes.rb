class CreatePerfumeDupes < ActiveRecord::Migration[7.1]
  def change
    create_table :perfume_dupes do |t|
      t.integer :original_perfume_id, null: false
      t.integer :dupe_id, null: false

      t.timestamps
    end

    add_foreign_key :perfume_dupes, :perfumes, column: :original_perfume_id
    add_foreign_key :perfume_dupes, :perfumes, column: :dupe_id
    add_index :perfume_dupes, :original_perfume_id
    add_index :perfume_dupes, :dupe_id
  end
end
