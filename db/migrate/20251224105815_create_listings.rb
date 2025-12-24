class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.references :marketplace_profile, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.float :price_cents
      t.float :quantity_ml
      t.string :condition
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
