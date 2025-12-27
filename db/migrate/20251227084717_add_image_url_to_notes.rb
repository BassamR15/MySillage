class AddImageUrlToNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :notes, :image_url, :string
  end
end
