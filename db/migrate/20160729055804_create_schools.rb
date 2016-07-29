class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :district, index: true, foreign_key: true
      t.string :name
      t.string :statute
      t.string :slug

      t.timestamps null: false
    end
    add_index :schools, :slug, unique: true
  end
end
