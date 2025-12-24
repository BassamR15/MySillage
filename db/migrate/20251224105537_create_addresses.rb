class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :marketplace_profile, null: false, foreign_key: true
      t.string :label
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :postal_code
      t.boolean :is_default

      t.timestamps
    end
  end
end
