class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :marketplace_profile, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.string :status
      t.float :total_cents
      t.string :stripe_payment_id
      t.datetime :shipped_at
      t.datetime :completed_at
      t.references :perfume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
