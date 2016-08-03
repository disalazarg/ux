class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :educations, :slug, unique: true
  end
end
