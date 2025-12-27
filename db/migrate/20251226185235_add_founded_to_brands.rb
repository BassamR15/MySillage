class AddFoundedToBrands < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :founded, :integer
  end
end
