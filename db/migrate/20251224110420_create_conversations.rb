class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.integer :buyer_id, null: false
      t.integer :seller_id, null: false
      t.references :listing, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end

    add_foreign_key :conversations, :marketplace_profiles, column: :buyer_id
    add_foreign_key :conversations, :marketplace_profiles, column: :seller_id
    add_index :conversations, :buyer_id
    add_index :conversations, :seller_id
  end
end
