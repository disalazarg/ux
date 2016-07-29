class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :school, index: true, foreign_key: true
      t.string :email
      t.string :name
      t.string :rbd
      t.string :slug

      t.timestamps null: false
    end
    add_index :contacts, :email, unique: true
    add_index :contacts, :slug, unique: true
  end
end
