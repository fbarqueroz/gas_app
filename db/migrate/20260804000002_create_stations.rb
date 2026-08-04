class CreateStations < ActiveRecord::Migration[7.1]
  def change
    create_table :stations do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.string :province
      t.string :canton
      t.string :address
      t.string :status, null: false, default: "active"

      t.timestamps
    end
  end
end
