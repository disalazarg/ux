class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :answer_id
      t.string :name
      t.string :link
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
    add_index :products, :answer_id, unique: true
    add_index :products, :slug, unique: true
  end
end
