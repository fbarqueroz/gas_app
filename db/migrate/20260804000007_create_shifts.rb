class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.references :station, null: false, foreign_key: true
      t.references :attendant, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: "open"
      t.datetime :opened_at, null: false
      t.datetime :closed_at

      t.timestamps
    end
  end
end
