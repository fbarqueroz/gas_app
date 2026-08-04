class CreateServicePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :service_points do |t|
      t.references :island, null: false, foreign_key: true
      t.string :label, null: false
      t.string :kind, null: false, default: "fuel_pump"
      t.string :status, null: false, default: "operational"

      t.timestamps
    end
  end
end
