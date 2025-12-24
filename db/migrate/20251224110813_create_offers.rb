class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :conversation, null: false, foreign_key: true
      t.integer :sender_id, null: false
      t.float :price_cents
      t.string :status
      t.text :ai_analyzed
      t.datetime :analyzed_at

      t.timestamps
    end

    add_foreign_key :offers, :marketplace_profiles, column: :sender_id
    add_index :offers, :sender_id
  end
end
