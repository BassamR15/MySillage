class CreateScentProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :scent_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :preferred_longevity
      t.string :preferred_intensity

      t.timestamps
    end
  end
end
