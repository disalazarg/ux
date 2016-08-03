class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :link
      t.text :description
      t.string :slug

      t.timestamps null: false
    end
    add_index :products, :slug, unique: true
  end
end
