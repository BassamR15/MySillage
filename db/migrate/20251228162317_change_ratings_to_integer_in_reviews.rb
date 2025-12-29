class ChangeRatingsToIntegerInReviews < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :rating_longevity, :integer
    change_column :reviews, :rating_value, :integer
    change_column :reviews, :rating_sillage, :integer
  end
end
