class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.string :category, null: false, default: "fuel"
      t.string :unit, null: false, default: "litro"
      t.integer :base_price_cents, null: false, default: 0

      t.timestamps
    end
  end
end
