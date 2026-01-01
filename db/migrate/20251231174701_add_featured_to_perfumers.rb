class AddFeaturedToPerfumers < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumers, :featured, :boolean
  end
end
