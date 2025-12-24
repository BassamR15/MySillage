class ChangePriceColumnsToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :price_alerts, :max_price_cents, :integer

    change_column :listings, :price_cents, :integer

    change_column :sale_records, :price_cents, :integer

    change_column :offers, :price_cents, :integer

    change_column :orders, :total_cents, :integer
  end
end
