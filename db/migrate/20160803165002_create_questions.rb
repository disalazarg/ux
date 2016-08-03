class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :poll, index: true, foreign_key: true
      t.text :statement

      t.timestamps null: false
    end
  end
end
