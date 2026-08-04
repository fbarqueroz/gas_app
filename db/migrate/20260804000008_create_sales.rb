class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :shift, null: false, foreign_key: true
      t.references :station, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :service_point, foreign_key: true

      t.decimal :quantity, precision: 10, scale: 3, null: false
      t.integer :unit_price_cents, null: false
      t.integer :total_cents, null: false
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
