class CreatePerfumes < ActiveRecord::Migration[7.1]
  def change
    create_table :perfumes do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :gender
      t.integer :launch_year

      t.timestamps
    end
  end
end
