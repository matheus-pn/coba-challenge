class CreateProductSubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_subcategories do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
