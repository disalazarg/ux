class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.references :province, index: true, foreign_key: true
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.string :slug

      t.timestamps null: false
    end
    add_index :districts, :slug, unique: true
  end
end
