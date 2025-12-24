class CreateLayerings < ActiveRecord::Migration[7.1]
  def change
    create_table :layerings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :base_perfume_id, null: false
      t.integer :top_perfume_id, null: false
      t.text :description
      t.integer :vote, default: 0

      t.timestamps
    end

    add_foreign_key :layerings, :perfumes, column: :base_perfume_id
    add_foreign_key :layerings, :perfumes, column: :top_perfume_id
    add_index :layerings, :base_perfume_id
    add_index :layerings, :top_perfume_id
  end
end
