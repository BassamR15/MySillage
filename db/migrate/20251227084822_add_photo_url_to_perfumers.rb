class AddPhotoUrlToPerfumers < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumers, :photo_url, :string
  end
end
