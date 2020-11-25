class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :location, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.string :parent_id

      t.timestamps
    end
  end
end
