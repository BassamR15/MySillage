class AddTrendingToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :trending, :boolean
  end
end
