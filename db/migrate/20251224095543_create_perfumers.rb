class CreatePerfumers < ActiveRecord::Migration[7.1]
  def change
    create_table :perfumers do |t|
      t.string :name
      t.text :bio

      t.timestamps
    end
  end
end
