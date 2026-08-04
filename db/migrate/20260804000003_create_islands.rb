class CreateIslands < ActiveRecord::Migration[7.1]
  def change
    create_table :islands do |t|
      t.references :station, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
