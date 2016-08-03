class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :product, index: true, foreign_key: true
      t.string :title
      t.date :finish
      t.text :intro
      t.string :slug

      t.timestamps null: false
    end
    add_index :polls, :slug, unique: true
  end
end
