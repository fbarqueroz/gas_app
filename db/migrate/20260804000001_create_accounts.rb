class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :legal_id
      t.string :api_token

      t.timestamps
    end
    add_index :accounts, :slug, unique: true
    add_index :accounts, :legal_id, unique: true
    add_index :accounts, :api_token, unique: true
  end
end
