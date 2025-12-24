class CreateSeasonVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :season_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reference
      t.references :perfume, null: false, foreign_key: true
      t.boolean :spring
      t.boolean :summer
      t.boolean :fall
      t.boolean :winter
      t.boolean :day
      t.boolean :night

      t.timestamps
    end
  end
end
