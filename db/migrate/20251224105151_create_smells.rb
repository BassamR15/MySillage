class CreateSmells < ActiveRecord::Migration[7.1]
  def change
    create_table :smells do |t|
      t.references :scent_profile, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true
      t.string :preference

      t.timestamps
    end
  end
end
