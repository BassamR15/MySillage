class CreatePriceAlerts < ActiveRecord::Migration[7.1]
  def change
    create_table :price_alerts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.float :max_price_cents
      t.integer :min_quantity_ml
      t.boolean :active

      t.timestamps
    end
  end
end
