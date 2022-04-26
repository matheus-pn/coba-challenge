class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :external_id, null: false
      t.date :placement_date

      t.timestamps
      t.index %i[external_id], unique: true
    end
  end
end
