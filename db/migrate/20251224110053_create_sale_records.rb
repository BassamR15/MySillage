class CreateSaleRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :sale_records do |t|
      t.references :perfume, null: false, foreign_key: true
      t.float :quantity_ml
      t.float :price_cents
      t.datetime :sold_at

      t.timestamps
    end
  end
end
