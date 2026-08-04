class CreateCashRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :cash_registers do |t|
      t.references :shift, null: false, foreign_key: true, index: { unique: true }
      t.integer :expected_cash_cents, null: false, default: 0
      t.integer :counted_cash_cents, null: false, default: 0
      t.integer :difference_cents, null: false, default: 0

      t.timestamps
    end
  end
end
