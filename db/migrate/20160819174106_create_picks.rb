class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :answer, index: true, foreign_key: true
      t.references :alternative, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
