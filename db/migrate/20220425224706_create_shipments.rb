class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.column :shipping_cost_cents, :bigint, null: false
      t.integer :priority, null: false, default: 0
      t.integer :shipment_mode, null: false
      t.string :province, null: false
      t.string :region, null: false
      t.date :shipment_date

      t.timestamps
    end
  end
end
