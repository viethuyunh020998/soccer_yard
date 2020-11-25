class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.integer :object_id
      t.integer :type, default: 0
      t.integer :action, default: 0

      t.timestamps
    end
  end
end
