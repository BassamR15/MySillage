class CreateOfferItems < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_items do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :listing, null: true, foreign_key: true
      t.references :collection, null: true, foreign_key: true
      t.float :quantity_ml
      t.string :condition

      t.timestamps
    end
  end
end
