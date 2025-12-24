class CreateSellerReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :seller_reviews do |t|
      t.references :order, null: false, foreign_key: true
      t.references :marketplace_profile, null: false, foreign_key: true
      t.text :content
      t.float :rating

      t.timestamps
    end
  end
end
