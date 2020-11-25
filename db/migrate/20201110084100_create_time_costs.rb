class CreateTimeCosts < ActiveRecord::Migration[6.0]
  def change
    create_table :time_costs do |t|
      t.references :yard, null: false, foreign_key: true
      t.string :time
      t.float :cost

      t.timestamps
    end
  end
end
