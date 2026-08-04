class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :sale, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"
      t.string :sinpe_reference
      t.string :card_last4
      t.string :card_token

      t.timestamps
    end
  end
end
