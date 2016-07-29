class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :code
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.string :slug

      t.timestamps null: false
    end
  end
end
