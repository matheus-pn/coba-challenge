class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :shipment, foreign_key: true

      t.integer :quantity, null: false, default: 1
      t.decimal :discount, precision: 3, scale: 2, null: false
      t.column :profit_cents, :bigint, null: false
      t.column :sales_cents, :bigint, null: false

      t.timestamps
    end
  end
end
