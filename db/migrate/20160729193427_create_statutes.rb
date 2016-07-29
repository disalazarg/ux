class CreateStatutes < ActiveRecord::Migration
  def change
    create_table :statutes do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :statutes, :slug, unique: true
  end
end
