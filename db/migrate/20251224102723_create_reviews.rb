class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.float :rating_overall
      t.float :rating_longevity
      t.float :rating_sillage
      t.float :rating_value
      t.text :content

      t.timestamps
    end
  end
end
