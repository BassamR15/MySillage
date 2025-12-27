class AddConcentrationToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :concentration, :string
  end
end
