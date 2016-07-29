class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.references :region, index: true, foreign_key: true
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.string :slug

      t.timestamps null: false
    end
    add_index :provinces, :slug, unique: true
  end
end
