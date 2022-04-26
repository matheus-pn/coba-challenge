class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :container, null: false
      t.decimal :base_margin
      t.references :product_category, null: false, foreign_key: true
      t.references :product_subcategory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
