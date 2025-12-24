class CreateDisputes < ActiveRecord::Migration[7.1]
  def change
    create_table :disputes do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :opened_by_id, null: false
      t.string :reason
      t.text :description
      t.string :status
      t.string :resolution

      t.timestamps
    end

    add_foreign_key :disputes, :marketplace_profiles, column: :opened_by_id
    add_index :disputes, :opened_by_id
  end
end
