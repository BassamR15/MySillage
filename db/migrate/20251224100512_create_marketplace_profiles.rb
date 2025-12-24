class CreateMarketplaceProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :marketplace_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_account_id
      t.boolean :onboarding_complete
      t.string :phone

      t.timestamps
    end
  end
end
