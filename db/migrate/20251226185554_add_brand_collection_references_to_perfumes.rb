class AddBrandCollectionReferencesToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_reference :perfumes, :brand_collection, null: false, foreign_key: true
  end
end
