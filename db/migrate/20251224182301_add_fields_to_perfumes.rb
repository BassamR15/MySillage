class AddFieldsToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :discontinued, :boolean, default: false
    add_column :perfumes, :discontinued_year, :integer, null: true
    add_column :perfumes, :reformulated, :boolean, default: false
    add_column :perfumes, :reformulation_year, :integer, null: true
  end
end
