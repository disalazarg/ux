class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string  :name
      t.decimal :lat
      t.decimal :lng
      t.string  :slug

      t.timestamps null: false
    end
    add_index :regions, :slug, unique: true
  end
end
