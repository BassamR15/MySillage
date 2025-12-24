class CreateVerifications < ActiveRecord::Migration[7.1]
  def change
    create_table :verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :perfume, null: false, foreign_key: true
      t.string :code
      t.date :production_date

      t.timestamps
    end
  end
end
