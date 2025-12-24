class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :name
      t.string :family

      t.timestamps
    end
  end
end
