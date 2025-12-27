class AddLogoUrlToBrands < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :logo_url, :string
  end
end
