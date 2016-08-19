class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.references :question, index: true, foreign_key: true
      t.integer :number
      t.text :statement

      t.timestamps null: false
    end
  end
end
