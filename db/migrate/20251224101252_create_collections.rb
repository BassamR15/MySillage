class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.integer :base_quantity_ml
      t.float :quantity_ml

      t.timestamps
    end
  end
end
