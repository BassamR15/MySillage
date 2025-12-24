class CreatePerfumeNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :perfume_notes do |t|
      t.references :perfume, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true
      t.string :note_type

      t.timestamps
    end
  end
end
