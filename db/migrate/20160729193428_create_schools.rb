class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.references :district, index: true, foreign_key: true
      t.references :statute, index: true, foreign_key: true
      t.references :education, index: true, foreign_key: true
      t.string :name
      t.string :rbd
      t.string :slug

      t.timestamps null: false
    end
    add_index :schools, :slug, unique: true
    add_index :schools, :rbd,  unique: true
  end
end
