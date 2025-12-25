class AddPriceToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :price_cents, :integer
  end
end
